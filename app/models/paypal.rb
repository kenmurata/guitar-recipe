class Paypal < ActiveRecord::Base
  require 'kconv'
  
  def self.import(file)
    puts 'import simasu'
    begin
      puts 'import simasu2'
      csv_text = file.read
      #ActiveRecord::Base.transaction do
        CSV.parse(Kconv.toutf8(csv_text), headers: true, return_headers: false) do |row|
          
          ### 'ウェブペイメント'以外の場合(支払いの返金や一般の引き出し)はユニーク制約やヌル制約に引っかかるので
          ### とりあえずは無視する。いずれそれ用の処理も入れる必要あり。(paypalの残金を管理する場合必要。)
          if row[4] == 'ウェブペイメント'
            if User.find_by(:email => row[10]) == nil
              user = User.new
              
              user.name = row[3]
              user.email = row[10]
              user.shipping_address = row[13]
              user.address_status = row[14]
              user.address_1st_line = row[30]
              user.address_2nd_line = row[31]
              user.municipality = row[32]
              user.prefecture = row[33]
              user.postal_code = row[34]
              user.country_name = row[35]
              user.country_code = row[39]
              user.telephone_number = row[36]
              
              user.save!
            end
            
            if Product.find_by(:paypal_product_id => row[16]) == nil
              product = Product.new
              
              product.price = row[9]
              product.fee = row[8]
              product.title = row[15]
              product.paypal_product_id = row[16]
              
              product.save!
            end
            
            if Purchase.find_by(:paypal_transaction_id => row[12]) == nil
              
              user_id = User.find_by(:email => row[10]).id
              product_id = Product.find_by(:paypal_product_id => row[16]).id
            
              purchase = Purchase.new
            
              purchase.user_id = user_id
              purchase.product_id = product_id
              purchase.time = Time.parse("#{row[0]} #{row[1]}")
              purchase.timezone = row[2]
              purchase.transaction_type = row[4]
              purchase.status = row[5]
              purchase.currency = row[6]
              purchase.payment_amount = row[7]
              purchase.paypal_transaction_id = row[12]
              purchase.shipping_fee = row[17]
              purchase.insurance_amount = row[18]
              purchase.tax = row[19]
              purchase.option1_name = row[20]
              purchase.option1_price = row[21]
              purchase.option2_name = row[22]
              purchase.option2_price = row[23]
              purchase.reference_transaction_id = row[24]
              purchase.invoice_number = row[25]
              purchase.custom_number = row[26]
              purchase.amount = row[27]
              purchase.receipt_id = row[28]
              purchase.balance = row[29]
              purchase.subject = row[37]
              purchase.remark = row[38]
              
              purchase.save!
            end
            #paypal = Paypal.new
            #paypal.date = row[0]
            #paypal.time = row[1]
            #paypal.timezone = row[2]
            #paypal.name = row[3]
            #paypal.transaction_type = row[4]
            #paypal.status = row[5]
            #paypal.currency = row[6]
            #paypal.sum = row[7]
            #paypal.fee = row[8]
            #paypal.net = row[9]
            #paypal.sender_email = row[10]
            #paypal.recipient_email = row[11]
            #paypal.transaction_id = row[12]
            #paypal.shipping_address = row[13]
            #paypal.address_status = row[14]
            #paypal.product_title = row[15]
            #paypal.product_id = row[16]
            #paypal.shipping_fee = row[17]
            #paypal.insurance_amount = row[18]
            #paypal.tax = row[19]
            #paypal.option1_name = row[20]
            #paypal.option1_price = row[21]
            #paypal.option2_name = row[22]
            #paypal.option2_price = row[23]
            #paypal.reference_transaction_id = row[24]
            #paypal.invoice_number = row[25]
            #paypal.custom_number = row[26]
            #paypal.amount = row[27]
            #paypal.receipt_id = row[28]
            #paypal.balance = row[29]
            #paypal.address_1st_line = row[30]
            #paypal.address_2nd_line = row[31]
            #paypal.municipality = row[32]
            #paypal.prefecture = row[33]
            #paypal.postal_code = row[34]
            #paypal.country_name = row[35]
            #paypal.telephone_number = row[36]
            #paypal.subject = row[37]
            #paypal.remark = row[38]
            #paypal.country_code = row[39]
            #paypal.balance_impact = row[40]
            
            #paypal.save!
          end
        end
      #end
    #rescue => e
      #puts e.backtrace
      #ActiveRecord::Rollback
    end
  end
  
  def self.updatable_attributes
    ["date","time","timezone","name","type","status","currency","sum","fee","net","sender_email","recipient_email","transaction_id","shipping_address","address_status","product_title","product_id","shipping_fee","insurance_amount","tax","option1_name","option1_price","option2_name","option2_price","reference_transaction_id","invoice_number","custom_number","amount","receipt_id","balance","address_1st_line","address_2nd_line","municipality","prefecture","postal_code","country_name","telephone_number","subject","remark","country_code","balance_impact"]
  end
end