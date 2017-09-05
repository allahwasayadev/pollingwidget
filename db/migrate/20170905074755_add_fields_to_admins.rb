class AddFieldsToAdmins < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :name, :string
    add_column :admins, :last_name, :string
    add_column :admins, :super_admin, :boolean, default: false
  end
end
