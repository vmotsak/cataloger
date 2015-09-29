class RegistrationsController < Devise::RegistrationsController

  def new
    super do |resource|
      resource.role = 'visitor'
    end
  end

  def admin
    build_resource(role: 'admin')
    render 'devise/registrations/new'
  end

  def owner
    build_resource(role: 'owner')
    render 'devise/registrations/new'
  end
end
