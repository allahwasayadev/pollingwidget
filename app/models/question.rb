class Question < ApplicationRecord
  belongs_to :category
  belongs_to :admin
  has_many :poll_questions
  has_many :polls, through: :poll_questions
  after_create :set_correct_option, if: :multiplechoice
  mount_uploader :image, ImageUploader

  def self.filter_questions(poll_params)
    if poll_params[:question_type].blank? && !poll_params[:category_id].blank?
      @questions = Question.where(category_id: poll_params[:category_id])
    elsif poll_params[:category_id].blank? && !poll_params[:question_type].blank?
      @questions = Question.where(question_type: poll_params[:question_type])
    elsif !poll_params[:question_type].blank? && !poll_params[:category_id].blank?
      @questions = Question.where(question_type: poll_params[:question_type], category_id: poll_params[:category_id])
    else
      @questions = Question.all
    end
    @questions
  end

  def set_correct_option
    self.correct_option = self.options["1"]
    self.save
  end

  def multiplechoice
    self.question_type == "Multi"
  end
end
