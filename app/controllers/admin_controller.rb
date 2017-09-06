class AdminController < ApplicationController
  before_filter :set_layout

  def index
    @admins = Admin.all
    @admin = Admin.new
  end

  def new
    @admin = Admin.new
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

  def show
    @admin = Admin.find(params[:id])
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    admin = Admin.find(params[:id])
    admin.update(admin_params)
    redirect_back(fallback_location: :back,notice: "User updated")
  end

  def destroy
    admin = Admin.find(params[:id])
    admin.delete
    redirect_to admin_index_url, alert: "Requested user has been deleted"
  end

  def account
    @admin = Admin.find(params[:id])
  end

  private

  def admin_params
    params.require(:admin).permit(:name,:last_name,:email)
  end

  def set_layout
    self.class.layout "dashboard"
  end

end
