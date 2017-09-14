class PollsController < ApplicationController
  before_filter :set_layout
  before_action :set_poll, only: [:update, :destroy,:show, :edit, :update]

  def index
    puts "---------------------------"
    puts params.inspect
    puts "---------------------------"
    puts "---------------------------"
    @poll = Poll.new
    @categories = Category.all
    @polls = Poll.all.includes(:category)
    @questions = Question.all.includes(:category)
    if params[:poll].blank?
      puts "===========all query========"
      @polls = Poll.all.includes(:category)
      puts "============================"
    else
      if poll_params[:poll_type].blank? && !poll_params[:category_id].blank?
        puts "===========category query =="
        @polls = Poll.where(category_id: poll_params[:category_id]).includes(:category)
        puts "============================"
      elsif poll_params[:category_id].blank? && !poll_params[:poll_type].blank?
        puts "===========poll query======="
        @polls = Poll.where(poll_type: poll_params[:poll_type]).includes(:category)
        puts "============================"
      elsif !poll_params[:poll_type].blank? && !poll_params[:category_id].blank?
        @polls = Poll.where(poll_type: poll_params[:poll_type], category_id: poll_params[:category_id]).includes(:category)
      else
        puts "========else case =========="
        @polls = Poll.all.includes(:category)
      end
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update_questions
    if params[:poll].blank?
      puts "===========all query========"
      @questions = Question.all.includes(:category)
      puts "============================"
    else
      if poll_params[:question_type].blank? && !poll_params[:category_id].blank?
        puts "===========category query =="
        @questions = Question.where(category_id: poll_params[:category_id]).includes(:category)
        puts "============================"
      elsif poll_params[:category_id].blank? && !poll_params[:question_type].blank?
        puts "===========poll query======="
        @questions = Question.where(question_type: poll_params[:question_type]).includes(:category)
        puts "============================"
      elsif !poll_params[:question_type].blank? && !poll_params[:category_id].blank?
        @questions = Question.where(question_type: poll_params[:question_type], category_id: poll_params[:category_id]).includes(:category)
      else
        @questions = Question.all.includes(:category)
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def new
    puts "==========================="
    puts "==========================="
    puts params.inspect
    puts "==========================="
    puts "==========================="
    @poll = Poll.new
    @categories = Category.all
    @question_ids = params[:question_ids].split(",")
    @category_id = params[:category_id]
    @poll_type = params[:poll_type]
    @questions = Question.where(id: @question_ids)
    puts "=========questions=========="
    puts @questions.inspect
  end

  def create
    @poll = Poll.new(poll_params)
    questions = Question.where(id: params[:question_ids])
    if @poll.save
      @poll.questions << questions
      redirect_to polls_url, notice: 'poll was successfully created.'
    else
      redirect_to polls_url, notice: 'poll could not be created.'
    end
  end

  def edit
    @categories = Category.all
  end

  def show

  end

  def update
    if poll_params[:poll_type] == "Multi"
      poll_params[:correct_option] = poll_params[:options]["1"]
    end
    @poll.update(poll_params)
    redirect_to polls_url, notice: 'poll was successfully updated.'
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
