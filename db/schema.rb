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

ActiveRecord::Schema[7.0].define(version: 2023_03_09_171941) do
  create_table "bills", force: :cascade do |t|
    t.string "title"
    t.integer "primary_sponsor_id"
    t.string "primary_sponsor_name"
    t.integer "supporter_count"
    t.integer "opposer_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "legislators", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "num_supported_bills"
    t.integer "num_opposed_bills"
  end

  create_table "vote_results", force: :cascade do |t|
    t.integer "legislator_id"
    t.integer "vote_id"
    t.integer "vote_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer "bill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
