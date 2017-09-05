class StaticPagesController < ApplicationController
  before_action :set_user
  skip_before_filter :authenticate_admin!

  def index
    if admin_signed_in?
      redirect_to admin_index_path
    end
  end

  private

  def set_user
    @user = Admin.new
  end

end
