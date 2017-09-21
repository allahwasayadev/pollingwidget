class PollsController < ApplicationController
  before_filter :set_layout
  before_action :set_poll, only: [:update, :destroy, :edit, :show, :update]

  def index
    @categories = Category.all
    if params[:poll].blank?
      @polls = Poll.all.includes(:category , :questions)
    else
      @polls = Poll.filter_polls(poll_params).includes(:category , :questions)
    end
    @polls = @polls.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update_questions
    if params[:poll].blank?
      @questions = Question.all.includes(:category , :polls)
    else
      @questions = Question.filter_questions(poll_params).includes(:category , :polls)
    end
    @questions = @questions.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.js
    end
  end

  def new
    @poll = Poll.new
    @categories = Category.all
    @questions = Question.all.includes(:category , :polls).paginate(:page => params[:page], :per_page => 10)
  end

  def create
    @question_ids = params[:question_ids].split(",")
    questions = Question.where(id: @question_ids)
    @poll = Poll.new(poll_params)
    if @poll.save
      @poll.questions << questions
      redirect_to polls_url, notice: 'poll was successfully created.'
    else
      redirect_to polls_url, notice: 'poll could not be created.'
    end
  end

  def show
    @poll_questions = @poll.questions
    @category = @poll.category
  end

  def destroy
    @poll.destroy
    redirect_back(fallback_location: :back,notice: "poll was successfully deleted.")
  end

  private

    def set_poll
      @poll = Poll.find(params[:id])
    end

    def set_layout
      self.class.layout "dashboard"
    end

    def poll_params
      params.require(:poll).permit(:category_id,:admin_id,:poll_type,:name,:question_type)
    end
end
