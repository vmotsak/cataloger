class Owner::ParameterSanitizer < Devise::ParameterSanitizer
  def sign_up
    default_params.permit(:name, :shop_name, :email, :password, :password_confirmation)
  end
end
