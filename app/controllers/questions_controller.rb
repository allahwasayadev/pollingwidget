class QuestionsController < AdminController
  before_action :set_question, only: [:update, :destroy,:show, :edit, :update]

  def index
    @question = Question.new
    @categories = Category.all
    @questions = Question.all.includes(:category)
  end

  def new
    @question = Question.new
    @categories = Category.all
  end

  def create
    # if params[:question_category_all].present? or params[:question][:category_id] == ""
    #   question_params[:category_id] = Category.find_by(name: "General").id
    # end
    @question = Question.new(question_params)
    # return render json:  question_params[:options]["1"]
    if question_params[:question_type] == "Multi"
      question_params[:correct_option] = question_params[:options]["1"]
    end
    if @question.save!
      redirect_to questions_url, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if params[:question_category_all].present? or params[:question][:category_id] == ""
      question_params[:category_id] = Category.find_by(name: "General").id
    end
    @question.update(question_params)
    redirect_to categories_admin_index_url, notice: 'Question was successfully updated.'
  end

  def destroy
    @question.destroy
    redirect_back(fallback_location: :back,notice: "Question was successfully deleted.")
  end

  private

    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:question,:category_id,:correct_option,:question_type,:image).tap do |whitelisted|
        whitelisted[:options] = params[:question][:options]
      end
      # params.require(:question).permit!
    end
end
