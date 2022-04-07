class AddTotalTime < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :total_time, :integer
  end
end
