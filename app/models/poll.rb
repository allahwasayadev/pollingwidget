class Poll < ApplicationRecord
  belongs_to :category
  belongs_to :admin
  has_many :poll_questions
  has_many :questions, through: :poll_questions

  def self.filter_polls(poll_params)
    if poll_params[:poll_type].blank? && !poll_params[:category_id].blank?
      @polls = Poll.where(category_id: poll_params[:category_id])
    elsif poll_params[:category_id].blank? && !poll_params[:poll_type].blank?
      @polls = Poll.where(poll_type: poll_params[:poll_type])
    elsif !poll_params[:poll_type].blank? && !poll_params[:category_id].blank?
      @polls = Poll.where(poll_type: poll_params[:poll_type], category_id: poll_params[:category_id])
    else
      @polls = Poll.all
    end
    @polls
  end
end
