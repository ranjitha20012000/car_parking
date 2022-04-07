class CreateVehicle < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :number
      t.string :name_or_mobile
      t.timestamp :in_time
      t.timestamp :out_time
      t.integer :fees
      t.string :status
      t.belongs_to :charge, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end