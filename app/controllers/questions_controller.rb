class QuestionsController < ApplicationController
  before_filter :set_layout
  before_action :set_question, only: [:update, :destroy,:show, :edit, :update]

  def index
    @question = Question.new
    @categories = Category.all
    @questions = Question.all.includes(:category).paginate(:page => params[:page], :per_page => 10)
    @category_id = params[:category_id] unless params[:category_id].blank?
  end

  def new
    @question = Question.new
    @categories = Category.all
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      if params[:commit] == "Create Another"
        redirect_to questions_url(category_id: question_params[:category_id]), notice: 'Question was successfully created.'
      else
        redirect_to questions_url, notice: 'Question was successfully created.'
      end
    else
      redirect_to questions_url, alert: 'Question could not be created.'
    end
  end

  def edit
    @categories = Category.all
  end

  def show

  end

  def update
    @question.update(question_params)
    if @question.question_type == "Multi"
      @question.set_correct_option
    end
    redirect_to questions_url, notice: 'Question was successfully updated.'
  end

  def destroy
    @question.destroy
    redirect_back(fallback_location: :back,notice: "Question was successfully deleted.")
  end

  private

    def set_question
      @question = Question.find(params[:id])
    end

    def set_layout
      self.class.layout "dashboard"
    end

    def question_params
      params.require(:question).permit(:question,:category_id,:admin_id,:correct_option,:question_type,:image,:options).tap do |whitelisted|
        whitelisted[:options] = params[:question][:options].permit! unless params[:question][:options].blank?
      end
      # params.require(:question).permit!
    end
end
