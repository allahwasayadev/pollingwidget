class PollsController < ApplicationController
  before_filter :set_layout
  before_action :set_poll, only: [:update, :destroy, :edit, :show, :update]

  def index
    @categories = Category.all
    if params[:poll].blank?
      @polls = Poll.all.includes(:category)
    else
      @polls = Poll.filter_polls(poll_params)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update_questions
    if params[:poll].blank?
      @questions = Question.all.includes(:category)
    else
      @questions = Question.filter_questions(poll_params)
    end
    respond_to do |format|
      format.js
    end
  end

  def new
    @poll = Poll.new
    @categories = Category.all
    @questions = Question.all.includes(:category)
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
