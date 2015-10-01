class VisitorMailer < ApplicationMailer

  def purchased(user,image_url)
    @image_url = image_url

    mail to: user.email
  end
end
