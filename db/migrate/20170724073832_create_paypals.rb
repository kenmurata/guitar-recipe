class CreatePaypals < ActiveRecord::Migration
  def change
    create_table :paypals do |t|
      t.string  :date
      t.string  :time
      t.string  :timezone
      t.string  :name
      t.string  :type
      t.string  :status
      t.string  :currency
      t.string  :sum
      t.string  :fee
      t.string  :net
      t.string  :sender_email
      t.string  :recipient_email
      t.string  :transaction_id
      t.string  :shipping_address
      t.string  :address_status
      t.string  :product_title
      t.string  :product_id
      t.string  :shipping_fee
      t.string  :insurance_amount
      t.string  :tax
      t.string  :option1_name
      t.string  :option1_price
      t.string  :option2_name
      t.string  :option2_price
      t.string  :reference_transaction_id
      t.string  :invoice_number
      t.string  :custom_number
      t.string  :amount
      t.string  :receipt_id
      t.string  :balance
      t.string  :address_1st_line
      t.string  :address_2nd_line
      t.string  :municipality
      t.string  :prefecture
      t.string  :postal_code
      t.string  :country_name
      t.string  :telephone_number
      t.string  :subject
      t.string  :remark
      t.string  :country_code
      t.string  :balance_impact
      t.timestamps null: false
    end
  end
end
