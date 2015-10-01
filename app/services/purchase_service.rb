class PurchaseService

  attr_reader :error

  def initialize(user)
    @user = user
  end

  def buy(product)
    if @user.email.end_with?('com')
      @error = "Your emails 'com' domain is not supported"
      send_error(@user, @error)
      return
    end

    # take picture
    photo = retrieve_photo
    # check picture is color valid add error && retrun
    if photo.color_valid?
      VisitorMailer.purchased(@user, photo.thumbnailUrl).deliver_now
      send_todo
    else
      @error = "Color mistmatch error"
      send_error(@user, @error)
    end
  end

  private
  def send_error(visitor, error)
    User.admins.find_each do |admin|
      AdminMailer.purchase_error(admin, visitor, error).deliver_now
    end
  end


  def send_todo
    todo_id = retrieve_todo_id
    User.admins.find_each do |admin|
      AdminMailer.todo(admin, todo_id).deliver_now
    end
  end

  def retrieve_photo
    json = JSON.parse(RestClient.get "http://jsonplaceholder.typicode.com/photos/#{rand(5000)}")
    Photo.new(json)
  end

  def retrieve_todo_id
    json = JSON.parse(RestClient.post "http://jsonplaceholder.typicode.com/todos", {})
    json['id']
  end
end
