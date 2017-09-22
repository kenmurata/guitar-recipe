class CsvController < ApplicationController
  
  require 'kconv'
  
  def import
    
    # 結果を表示するためのカウンタ
    @total_column = 0
    @user_num = 0
    @product_num = 0
    @purchase_num = 0
    
    puts "#{params[:commit]}"
    
    csv_text = params[:file].read
    CSV.parse(Kconv.toutf8(csv_text), headers: true, return_headers: false) do |row|
      
      # paypal と infotopを判断してそれぞれに合った取り込み方をする
      if params[:commit] == "paypal"
          
        ### 'ウェブペイメント'以外の場合(支払いの返金や一般の引き出し)はユニーク制約やヌル制約に引っかかるので
        ### とりあえずは無視する。いずれそれ用の処理も入れる必要あり。(paypalの残金を管理する場合必要。)
        if row[4] == 'ウェブペイメント'
        
          @total_column += 1
          
          if User.find_by(:email => row[10]) == nil
          
            # 結果を表示するためにカウンタをインクリメント
            @user_num += 1
          
            # 新規オブジェクト作成
            user = User.new
          
            # パラメータの代入
            user.name = row[3]
            user.email = row[10]
            user.shipping_address = row[13]
            if row[14] == '確認済み' 
              user.address_status = true
            else
              user.address_status = false
            end
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
          
            # カウンタのインクリ
            @product_num += 1
            
            # 新規オブジェクト作成
            product = Product.new
            
            # paypalから買った
            product.publisher = 'paypal'
              
            # パラメータの代入
            #product.price = row[7].gsub(',','').to_i
            product.title = row[15]
            product.paypal_product_id = row[16]
            
            product.save!
          end
        
          if Purchase.find_by(:paypal_transaction_id => row[12]) == nil
            
            # カウンタのインクリ
            @purchase_num += 1
          
            # 新規オブジェクト作成
            purchase = Purchase.new
          
            # 先に登録したユーザIDと商品IDを取得
            user_id = User.find_by(:email => row[10]).id
            product_id = Product.find_by(:paypal_product_id => row[16]).id
        
            # その他のパラメータの代入
            purchase.user_id = user_id
            purchase.product_id = product_id
            purchase.time = Time.parse("#{row[0]} #{row[1]}")
            purchase.timezone = row[2]
            purchase.transaction_type = row[4]
            purchase.status = row[5]
            purchase.currency = row[6]
            purchase.fee = row[8].gsub(',','').to_i
            purchase.payment_amount = row[9].gsub(',','').to_i
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
            
            purchase.price = row[7].gsub(',','').to_i
            
            purchase.save!
          end
        end
      ################################################
      # ここからinfotopの処理
      ################################################
      elsif params[:commit] == "infotop"
        @total_column += 1
          
        if User.find_by(:email => row[4]) == nil
          
          # 結果を表示するためにカウンタをインクリメント
          @user_num += 1
            
          # 新規オブジェクト作成
          user = User.new
          
          # パラメータの代入
          user.name = row[3]
          user.email = row[4]
          #user.shipping_address = row[13]
          #if row[14] == '確認済み' 
            #user.address_status = true
          #else
            #user.address_status = false
          #end
          user.address_1st_line = row[12]
          #user.address_2nd_line = row[31]
          user.municipality = row[11]
          user.prefecture = row[10]
          user.postal_code = row[13]
          ##user.country_name = row[35]
          #user.country_code = row[39]
          user.telephone_number = row[14]
            
          user.save!
        end
            
        # infotopの場合は商品IDが存在しない。なので商品を一意に特定するキーとして
        # 商品名を使うことにする(潮との相談結果)
        # 結果的にinfotopから登録された商品には title と paypal_product_id に商品名が入る
        # (元もpaypalだけしか存在しなかった時点ではカラム名を(product_idではなく)paypal_product_idとしていた
        # が、変更がめんどいのでそのままにする)
        if Product.find_by(:paypal_product_id => row[5]) == nil
          
          # カウンタのインクリ
          @product_num += 1
              
          # 新規オブジェクト作成
          product = Product.new
              
          # どこで公開している商品か
          product.publisher = 'infotop'
                
          # パラメータの代入
          # (上記の通り、商品名、商品IDの両方に商品名を入れる)
          product.title = row[5]
          product.paypal_product_id = row[5]
          
          product.save!
        end
          
        if Purchase.find_by(:paypal_transaction_id => row[1]) == nil
              
          # カウンタのインクリ
          @purchase_num += 1
            
          # 新規オブジェクト作成
          purchase = Purchase.new
            
          # 先に登録したユーザIDと商品IDを取得
          user_id = User.find_by(:email => row[4]).id
          product_id = Product.find_by(:paypal_product_id => row[5]).id
          
          # その他のパラメータの代入
          purchase.user_id = user_id
          purchase.product_id = product_id
          purchase.time = Time.parse(row[0])
          #purchase.timezone = row[2]
          #purchase.transaction_type = row[4]
          #purchase.status = row[5]
          #purchase.currency = row[6]
          #purchase.fee = row[8].gsub(',','').to_i
          #purchase.payment_amount = row[9].gsub(',','').to_i
          purchase.paypal_transaction_id = row[5]
          purchase.shipping_fee = row[9]
          #purchase.insurance_amount = row[18]
          #purchase.tax = row[19]
          #purchase.option1_name = row[20]
          #purchase.option1_price = row[21]
          #purchase.option2_name = row[22]
          #purchase.option2_price = row[23]
          #purchase.reference_transaction_id = row[24]
          #purchase.invoice_number = row[25]
          #purchase.custom_number = row[26]
          #purchase.amount = row[27]
          #purchase.receipt_id = row[28]
          #purchase.balance = row[29]
          #purchase.subject = row[37]
          #purchase.remark = row[38]
              
          purchase.price = row[8].to_i
              
          purchase.save!
            
        end
      end   # if row[4] == 'ウェブペイメント'
    end     #CSV.parse
    
    @result = '成功'
    
  end       #def import
  
end
