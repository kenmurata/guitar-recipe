class CreateProduct < ActiveRecord::Migration
  def change
    create_table "products", force: :cascade do |t|
      t.integer  "price",             null: false
      t.text     "title",             null: false
      t.text     "paypal_product_id", null: false
      t.datetime "created_at",        null: false
      t.datetime "updated_at",        null: false
    end

    create_table "purchases", force: :cascade do |t|
      t.time     "time"
      t.string   "timezone"
      t.string   "transaction_type"
      t.string   "status"
      t.string   "currency"
      t.integer  "fee"
      t.integer  "payment_amount"
      t.string   "paypal_transaction_id",    null: false
      t.integer  "shipping_fee"
      t.string   "insurance_amount"
      t.integer  "tax"
      t.string   "option1_name"
      t.string   "option1_price"
      t.string   "option2_name"
      t.string   "option2_price"
      t.string   "reference_transaction_id"
      t.string   "invoice_number"
      t.string   "custom_number"
      t.integer  "amount"
      t.string   "receipt_id"
      t.integer  "balance"
      t.string   "subject"
      t.string   "remark"
      t.datetime "created_at",               null: false
      t.datetime "updated_at",               null: false
      t.integer  "user_id"
      t.integer  "product_id"
    end
  end
end
