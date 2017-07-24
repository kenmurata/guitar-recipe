class Paypal < ActiveRecord::Base
  require 'kconv'
  
  def self.import(file)
    puts 'import simasu'
    begin
      puts 'import simasu2'
      csv_text = file.read
      puts csv_text.class
      puts csv_text
      ActiveRecord::Base.transaction do
        CSV.parse(Kconv.toutf8(csv_text), headers: true, return_headers: false) do |row|
          paypal = Paypal.new
          #paypal.attributes = row.to_hash.slice(*updatable_attributes)
          #puts row
          #puts row.class
          paypal.date = row[0]
          paypal.time = row[1]
          paypal.timezone = row[2]
          paypal.name = row[3]
          paypal.transaction_type = row[4]
          paypal.status = row[5]
          paypal.currency = row[6]
          paypal.sum = row[7]
          paypal.fee = row[8]
          paypal.net = row[9]
          paypal.sender_email = row[10]
          paypal.recipient_email = row[11]
          paypal.transaction_id = row[12]
          paypal.shipping_address = row[13]
          paypal.address_status = row[14]
          paypal.product_title = row[15]
          paypal.product_id = row[16]
          paypal.shipping_fee = row[17]
          paypal.insurance_amount = row[18]
          paypal.tax = row[19]
          paypal.option1_name = row[20]
          paypal.option1_price = row[21]
          paypal.option2_name = row[22]
          paypal.option2_price = row[23]
          paypal.reference_transaction_id = row[24]
          paypal.invoice_number = row[25]
          paypal.custom_number = row[26]
          paypal.amount = row[27]
          paypal.receipt_id = row[28]
          paypal.balance = row[29]
          paypal.address_1st_line = row[30]
          paypal.address_2nd_line = row[31]
          paypal.municipality = row[32]
          paypal.prefecture = row[33]
          paypal.postal_code = row[34]
          paypal.country_name = row[35]
          paypal.telephone_number = row[36]
          paypal.subject = row[37]
          paypal.remark = row[38]
          paypal.country_code = row[39]
          paypal.balance_impact = row[40]
          
          paypal.save!
        end
      end
    rescue => e
      puts e.backtrace
      ActiveRecord::Rollback
    end
  end
  
  def self.updatable_attributes
    ["date","time","timezone","name","type","status","currency","sum","fee","net","sender_email","recipient_email","transaction_id","shipping_address","address_status","product_title","product_id","shipping_fee","insurance_amount","tax","option1_name","option1_price","option2_name","option2_price","reference_transaction_id","invoice_number","custom_number","amount","receipt_id","balance","address_1st_line","address_2nd_line","municipality","prefecture","postal_code","country_name","telephone_number","subject","remark","country_code","balance_impact"]
  end
end
