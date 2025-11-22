class TimeSheetsTable < ActiveRecord::Migration[8.1]
  def change
    create_table :time_sheets do |t|
      t.string :description, null: false
      t.decimal :rate, precision: 10, scale: 2, null: false
      t.integer :total_time, null: true
      t.integer :total_cost, null: true
      t.timestamps
    end
  end
end
