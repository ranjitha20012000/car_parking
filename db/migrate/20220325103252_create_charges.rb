class CreateCharges < ActiveRecord::Migration[7.0]
  def change
    create_table :charges do |t|
      t.string :type
      t.integer :min_charge
      t.integer :min_hours
      t.integer :extra_hour_charges
      
      t.timestamps
    end
  end
end
