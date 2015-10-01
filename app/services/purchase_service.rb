class PurchaseService

=begin
    И товары не могут покупать юзеры если у них email в зоне com.
Например "aaa@gmail.com" должен получить сообщение об ошибке, а "bbb@mail.org" - нет.

    Покупка заключается в том, чтобы взять случайную картинку
из http://jsonplaceholder.typicode.com/photos/ и отправить ее в письме гостю.
Плюс нужно сделать POST-запрос к http://jsonplaceholder.typicode.com/todos
и отправить id из ответа всем админам в системе
(да, система возвращает постоянно один и тот же id,
но мы будем представлять что он каждый раз разный).

    Это все только в случае успеха. Может случиться ошибка при покупке.
Ошибка случается тогда, когда цвет thumbnailUrl "больше" цвета url
Имеются в виду последние 6 символов урла картинок.
Видно что это просто это значение цвета, в шестнадцатиричном виде.

    На примере ниже "покупка" должна закончиться неуспешно, т.к. dff9f6 больше чем 771796

  {
    albumId: 1,
    id: 2,
    title: "reprehenderit est deserunt velit ipsam",
    url: "http://placehold.it/600/771796",
    thumbnailUrl: "http://placehold.it/150/dff9f6"
  }
  В случае ошибки, админам нужно отправить сообщение с email-ом юзера, а гостю нужно показать сообщение об ошибке.

    Админ и владелец магазина не могут покупать товары

  UPDATE Юзеру нужно не просто показать "ERROR" в случае ошибки. Ему нужно показать какая ошибка произошла.
=end
  attr_reader :error

  def initialize(user)
    @user = user
  end

  def buy(product)
    if @user.email.end_with?('com')
      @error = "Your emails 'com' domain is not supported"
      return
    end

    # take picture
    photo = retrieve_photo
    # check picture is color valid add error && retrun
    if photo.color_valid?
      # send mail to user
      todo_id = retrieve_todo_id
      puts 'purchase complete'
      # get todos and send id to all admins
    else
      @error = "Color mistmatch error"
    end
  end

  private

  def retrieve_photo
    json = JSON.parse(RestClient.get "http://jsonplaceholder.typicode.com/photos/#{rand(5000)}")
    Photo.new(json)
  end

  def retrieve_todo_id
    json = JSON.parse(RestClient.post "http://jsonplaceholder.typicode.com/todos", {})
    json[:id]
  end
end
