class CreatePollQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :poll_questions do |t|
      t.integer :poll_id
      t.integer :question_id

      t.timestamps
    end
  end
end
