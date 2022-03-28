class AddUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :full_name, :string
    add_column :users, :admin, :boolean
    add_column :users, :full_name, :string
  end
end
