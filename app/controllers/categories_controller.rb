class CategoriesController < ApplicationController
  before_filter :set_layout
  before_filter :set_category, only: [:show,:edit,:update,:account,:destroy]

  def index
    @categories = Category.all
    @category = Category.new
  end

  def new
    @category = Category.new
  end

  def create
    # return render json: category_params
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_url, notice: 'category was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @category.update(category_params)
    redirect_back(fallback_location: :back,notice: "Category updated")
  end

  def destroy
    @category.delete
    redirect_to categories_url, alert: "Requested category has been deleted"
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_layout
    self.class.layout "dashboard"
  end

  def set_category
    @category = Category.find(params[:id])
  end

end
