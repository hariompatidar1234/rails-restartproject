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

ActiveRecord::Schema[7.0].define(version: 2023_08_28_061157) do
  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.decimal "price", precision: 5, scale: 2
    t.integer "quantity", default: 0, null: false
    t.integer "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_books_on_member_id"
    t.index ["title"], name: "index_books_on_title", unique: true
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "email"
    t.string "password"
    t.string "contact"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "quantity"
    t.integer "book_id", null: false
    t.integer "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_orders_on_book_id"
    t.index ["member_id"], name: "index_orders_on_member_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "rate"
    t.text "comment"
    t.integer "book_id", null: false
    t.integer "member_id", null: false
    t.integer "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_ratings_on_book_id"
    t.index ["member_id"], name: "index_ratings_on_member_id"
    t.index ["order_id"], name: "index_ratings_on_order_id"
  end

  add_foreign_key "books", "members"
  add_foreign_key "orders", "books"
  add_foreign_key "orders", "members"
  add_foreign_key "ratings", "books"
  add_foreign_key "ratings", "members"
  add_foreign_key "ratings", "orders"
end
