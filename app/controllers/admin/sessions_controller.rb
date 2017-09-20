class Admin::SessionsController < Devise::SessionsController

  protected

  def after_sign_in_path_for(resource)
    account_admin_path(current_admin)
  end

end
