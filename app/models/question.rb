class Question < ApplicationRecord
  belongs_to :category
  belongs_to :admin
  has_many :poll_questions
  has_many :polls, through: :poll_questions
  mount_uploader :image, ImageUploader
end
