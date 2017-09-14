class PollQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :poll
end
