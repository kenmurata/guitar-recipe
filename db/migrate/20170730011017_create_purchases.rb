class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      
      t.time :time
      t.string :timezone
      t.string :transaction_type
      t.string :status
      t.string :currency
      t.string :payment_amount
      t.string :paypal_transaction_id, null: false, unique: true
      t.integer :shipping_fee
      t.string :insurance_amount
      t.integer :tax
      t.string :option1_name
      t.string :option1_price
      t.string :option2_name
      t.string :option2_price
      t.string :reference_transaction_id
      t.string :invoice_number
      t.string :custom_number
      t.integer :amount
      t.string :receipt_id
      t.integer :balance
      t.string :subject
      t.string :remark

      t.timestamps null: false
    end
  end
end
