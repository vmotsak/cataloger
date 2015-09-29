class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  respond_to :html

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :role, :last_name, :avatar, :passport_photo, :shop_name, :email, :password, :password_confirmation) }
  end
end
