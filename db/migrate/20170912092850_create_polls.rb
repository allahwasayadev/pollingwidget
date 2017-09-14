class CreatePolls < ActiveRecord::Migration[5.0]
  def change
    create_table :polls do |t|
      t.string :name
      t.string :poll_type
      t.integer :category_id
      t.integer :admin_id

      t.timestamps
    end
  end
end
