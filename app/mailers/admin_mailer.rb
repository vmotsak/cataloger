class AdminMailer < ApplicationMailer

  def purchase_error(admin, visitor,error)
    @error = error
    @visitor = visitor

    mail to: admin.email
  end

  def todo(admin, id)
    @id = id
    mail to: admin.email
  end
end
