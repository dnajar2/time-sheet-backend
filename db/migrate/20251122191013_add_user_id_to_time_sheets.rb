class AddUserIdToTimeSheets < ActiveRecord::Migration[8.1]
  def change
    add_reference :time_sheets, :user, null: true, foreign_key: true
  end
end
