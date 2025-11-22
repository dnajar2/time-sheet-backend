# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_11_22_191923) do
  create_table "line_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "date", null: false
    t.integer "minutes", null: false
    t.integer "time_sheet_id", null: false
    t.datetime "updated_at", null: false
    t.index ["time_sheet_id"], name: "index_line_items_on_time_sheet_id"
  end

  create_table "time_sheets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description", null: false
    t.decimal "rate", precision: 10, scale: 2, null: false
    t.integer "total_cost"
    t.integer "total_time"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_time_sheets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "password_digest"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "line_items", "time_sheets"
  add_foreign_key "time_sheets", "users"
end
