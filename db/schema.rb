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

ActiveRecord::Schema[8.0].define(version: 2025_01_14_214935) do
  create_table "communities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_communities_on_user_id"
  end

  create_table "event_attendees", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_attendees_on_event_id"
    t.index ["user_id"], name: "index_event_attendees_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "date"
    t.integer "user_id", null: false
    t.integer "community_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_events_on_community_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "title"
    t.integer "poll_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poll_id"], name: "index_options_on_poll_id"
  end

  create_table "polls", force: :cascade do |t|
    t.string "title"
    t.datetime "end_time"
    t.integer "community_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_polls_on_community_id"
    t.index ["user_id"], name: "index_polls_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.integer "user_id", null: false
    t.integer "community_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_posts_on_community_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "option_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_id"], name: "index_votes_on_option_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "communities", "users"
  add_foreign_key "event_attendees", "events"
  add_foreign_key "event_attendees", "users"
  add_foreign_key "events", "communities"
  add_foreign_key "events", "users"
  add_foreign_key "options", "polls"
  add_foreign_key "polls", "communities"
  add_foreign_key "polls", "users"
  add_foreign_key "posts", "communities"
  add_foreign_key "posts", "users"
  add_foreign_key "votes", "options"
  add_foreign_key "votes", "users"
end
