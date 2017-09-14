class Poll < ApplicationRecord
  belongs_to :category
  belongs_to :admin
  has_many :poll_questions
  has_many :questions, through: :poll_questions
end
