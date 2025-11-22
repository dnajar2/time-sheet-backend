class MakeUserIdNotNullOnTimeSheets < ActiveRecord::Migration[8.1]
  def change
    change_column_null :time_sheets, :user_id, false
  end
end
