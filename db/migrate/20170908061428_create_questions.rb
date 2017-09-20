class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.integer :category_id
      t.text :question
      t.jsonb :options
      t.string :correct_option
      t.string :image
      t.string :question_type
      t.integer :admin_id

      t.timestamps
    end
  end
end
