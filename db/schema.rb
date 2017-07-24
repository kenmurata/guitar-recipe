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

ActiveRecord::Schema.define(version: 20170724085945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "category"
    t.integer  "price"
    t.integer  "add_price"
    t.date     "day"
    t.integer  "expense"
    t.integer  "income"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "paypals", force: :cascade do |t|
    t.string   "date"
    t.string   "time"
    t.string   "timezone"
    t.string   "name"
    t.string   "type"
    t.string   "status"
    t.string   "currency"
    t.string   "sum"
    t.string   "fee"
    t.string   "net"
    t.string   "sender_email"
    t.string   "recipient_email"
    t.string   "transaction_id"
    t.string   "shipping_address"
    t.string   "address_status"
    t.string   "product_title"
    t.string   "product_id"
    t.string   "shipping_fee"
    t.string   "insurance_amount"
    t.string   "tax"
    t.string   "option1_name"
    t.string   "option1_price"
    t.string   "option2_name"
    t.string   "option2_price"
    t.string   "reference_transaction_id"
    t.string   "invoice_number"
    t.string   "custom_number"
    t.string   "amount"
    t.string   "receipt_id"
    t.string   "balance"
    t.string   "address_1st_line"
    t.string   "address_2nd_line"
    t.string   "municipality"
    t.string   "prefecture"
    t.string   "postal_code"
    t.string   "country_name"
    t.string   "telephone_number"
    t.string   "subject"
    t.string   "remark"
    t.string   "country_code"
    t.string   "balance_impact"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "transaction_type"
  end

  create_table "paypaltransactions", force: :cascade do |t|
    t.string "date"
    t.string "time"
    t.string "timezone"
    t.string "name"
    t.string "type"
    t.string "status"
    t.string "currency"
    t.string "sum"
    t.string "fee"
    t.string "net"
    t.string "sender_email"
    t.string "recipient_email"
    t.string "transaction_id"
    t.string "shipping_address"
    t.string "address_status"
    t.string "product_title"
    t.string "product_id"
    t.string "shipping_fee"
    t.string "insurance_amount"
    t.string "tax"
    t.string "option1_name"
    t.string "option1_price"
    t.string "option2_name"
    t.string "option2_price"
    t.string "reference_transaction_id"
    t.string "invoice_number"
    t.string "custom_number"
    t.string "amount"
    t.string "receipt_id"
    t.string "balance"
    t.string "address_1st_line"
    t.string "address_2nd_line"
    t.string "municipality"
    t.string "prefecture"
    t.string "postal_code"
    t.string "country_name"
    t.string "telephone_number"
    t.string "subject"
    t.string "remark"
    t.string "country_code"
    t.string "balance_impact"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "price",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "category"
    t.date     "release"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sources", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "fname",       null: false
    t.string   "lname",       null: false
    t.string   "fname_kana"
    t.string   "lname_kana"
    t.boolean  "sex"
    t.string   "email1",      null: false
    t.string   "email2"
    t.string   "postal_code", null: false
    t.string   "prefecture",  null: false
    t.string   "city",        null: false
    t.string   "tel",         null: false
    t.date     "birth"
    t.integer  "history"
    t.integer  "guitar_num"
    t.text     "genre"
  end

end
