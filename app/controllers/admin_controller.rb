class AdminController < ApplicationController
  before_filter :set_layout

  def index
    @admins = Admin.all
    @user = Admin.new
  end

  def new
    @user = Admin.new
  end

  def create
    # return render json: admin_params
    @admin = Admin.new(admin_params)
    if @admin.save
      NotificationMailer.new_user_notification(admin_params).deliver
      redirect_to admin_index_url, notice: 'Admin was successfully created.'
    else
      render :new
    end
  end

  def destroy
    admin = Admin.find(params[:id])
    admin.delete
    redirect_to admin_index_url, alert: "Requested user has been deleted"
  end

  private

  def admin_params
    params.require(:admin).permit(:name,:last_name,:email,:password,:password_confirmation)
  end

  def set_layout
    self.class.layout "dashboard"
  end

end
