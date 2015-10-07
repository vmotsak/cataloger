class Admin::ParameterSanitizer < Devise::ParameterSanitizer
  def sign_up
    default_params.permit(:name, :last_name, :avatar, :passport_photo, :email,
                          :password, :password_confirmation)
  end
end
