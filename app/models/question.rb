class Question < ApplicationRecord
  belongs_to :category
  belongs_to :admin
  has_many :poll_questions
  has_many :polls, through: :poll_questions
  mount_uploader :image, ImageUploader

  def self.filter_questions(poll_params)
    if poll_params[:question_type].blank? && !poll_params[:category_id].blank?
      @questions = Question.where(category_id: poll_params[:category_id]).includes(:category)
    elsif poll_params[:category_id].blank? && !poll_params[:question_type].blank?
      @questions = Question.where(question_type: poll_params[:question_type]).includes(:category)
    elsif !poll_params[:question_type].blank? && !poll_params[:category_id].blank?
      @questions = Question.where(question_type: poll_params[:question_type], category_id: poll_params[:category_id]).includes(:category)
    else
      @questions = Question.all.includes(:category)
    end
    @questions
  end
end
