class LineItemsTable < ActiveRecord::Migration[8.1]
  def change
    create_table :line_items do |t|
      t.references :time_sheet, null: false, foreign_key: true
      t.string :date, null: false
      t.integer :minutes, null: false
      t.timestamps
    end
  end
end
