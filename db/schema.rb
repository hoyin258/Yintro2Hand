# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140504003409) do

  create_table "comments", force: true do |t|
    t.string   "message"
    t.integer  "item_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["item_id"], name: "index_comments_on_item_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "items", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "price",         default: 0
    t.integer  "watch_count",   default: 0
    t.integer  "like_count",    default: 0
    t.integer  "dislike_count", default: 0
    t.integer  "location_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["location_id"], name: "index_items_on_location_id"
  add_index "items", ["user_id"], name: "index_items_on_user_id"

  create_table "items_tags", id: false, force: true do |t|
    t.integer "item_id", null: false
    t.integer "tag_id",  null: false
  end

  add_index "items_tags", ["item_id", "tag_id"], name: "index_items_tags_on_item_id_and_tag_id"
  add_index "items_tags", ["tag_id", "item_id"], name: "index_items_tags_on_tag_id_and_item_id"

  create_table "locations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pictures", ["item_id"], name: "index_pictures_on_item_id"

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "facebook_name"
    t.string   "password_digest"
    t.string   "facebook_id",          default: "", null: false
    t.string   "facebook_accesstoken"
    t.string   "token"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["facebook_id"], name: "index_users_on_facebook_id", unique: true

end
