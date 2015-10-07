class ApplicationController < ActionController::Base
  include Pundit
  # before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  respond_to :html

  def devise_parameter_sanitizer
    key = resource_class.to_s.downcase.to_sym
    "#{resource_class}::ParameterSanitizer".constantize.new(resource_class, key, params)
  rescue NameError
    super # Use the default one
  end
end
