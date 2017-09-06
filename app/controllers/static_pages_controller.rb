class StaticPagesController < ApplicationController
  before_action :set_user
  skip_before_filter :authenticate_admin!

  def index
    if admin_signed_in?
      redirect_to account_admin_path
    end
  end

  private

  def set_user
    @user = Admin.new
  end

end
