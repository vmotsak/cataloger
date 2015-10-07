class PurchaseService

  attr_reader :error

  def initialize(user)
    @user = user
  end

  def buy
    if @user.email.end_with?('com')
      @error = "Your emails 'com' domain is not supported"
      send_error(@user, @error)
      return
    end

    begin
      photo = APIClient.retrieve_photo
      # check picture is color valid add error && retrun
      if photo.color_valid?
        VisitorMailer.purchased(@user, photo.thumbnailUrl).deliver_now
        send_todo
      else
        @error = "Color mistmatch error"
        send_error(@user, @error)
      end
    rescue APIClient::CommunicationError
      @error = "Backend communication error"
      send_error(@user, @error)
    end
  end

  private

  def send_error(visitor, error)
    Admin.all.find_each do |admin|
      AdminMailer.purchase_error(admin, visitor, error).deliver_now
    end
  end


  def send_todo
    todo_id = APIClient.retrieve_todo_id
    Admin.all.find_each do |admin|
      AdminMailer.todo(admin, todo_id).deliver_now
    end
  end
end
