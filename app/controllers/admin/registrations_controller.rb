class Admin::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    admin_index_path
  end
end
