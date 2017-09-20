class Admin::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    account_admin_path(current_admin)
  end
end
