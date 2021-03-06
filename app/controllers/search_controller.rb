class SearchController < ApplicationController
    def index
    end
    
    ### 購入履歴から検索
    def product_search
      
      # 購入履歴に存在するuser_idを格納する配列
      user_ids = []
      @users_data = []
      
      # 商品ID
      @product = Product.find(params[:product][:product_id])
      
      # 商品の購入履歴一覧を取得
      @purchases = @product.purchase
      
      # 購入履歴に含まれているユーザ一覧を取得
      @purchases.each do |purchase|
        user_ids << purchase.user_id
      end
      
      # 持っている人 or いない人で条件分岐
      if params[:has_or_not][:has] == "yes"
        
        ## 検索条件が[持っている人]の場合の処理
        # 購入履歴に含まれているユーザオブジェクトを全て取得
        users = User.find(user_ids)
        users.each do |user|
          @users_data << {:id => user.id, :name => user.name, :email => user.email}
        end
        
        # 表示する内容(いる or いない)
        @message = "いる"
        
      else
        
        ### 検索条件が[持っていない人]の場合の処理
        ### 全ユーザの情報を一度取得し、その後購入しているユーザの情報だけ削除する
        users_data_array = User.all.pluck(:id, :name, :email)
        
        ### 購入していないユーザの情報だけを@users_dataに格納するループ
        users_data_array.each do |u|
          
          # 持っているかどうかの判定フラグ. 0 = 持っていない
          flag = 0
          
          # 持っているかの判定。持っているリスト分ループし、idが一致すればflag = 1
          user_ids.each do |uid|
            if u[0] == uid
              flag = 1
            end
          end
          
          # 持っていない(flag==0)なら持っていないリストに情報を代入
          if flag == 0
            @users_data << {:id => u[0], :name => u[1], :email => u[2]}
          end
        end
        
        # 表示する内容(いる or いない)
        @message = "いない"
      end
    end
    
    ### ユーザ情報から検索
    def user_search
      sql = create_query(params)
      
      # ヒットしたユーザの一覧が@usersに入る
      @users = User.where(sql).order('id desc')
      
      # ユーザの情報を表示するためのカラムを準備
      @user_column = []
      User.column_names.each do |c|
        if c == "id" || c == "created_at" || c == "updated_at"
        else
          @user_column.push c
        end
      end
      
      # 購入履歴を表示するための情報
      @purchases = Purchase.all
      @products = Product.all
      
    end
    
    private
      # 検索するqueryを作る関数
      def create_query(params)
        
        # 変数の初期化
        sql = []
        key = []
        query = ""
        count = 0
        
        # viewから受け取ったパラメータのチェック
        params.each do |param|
          
          # ユーザのデータではないヘッダ部分は除外
          if param[0] == "utf8" || param[0] == "commit" || param[0] == "controller" || param[0] == "action"
          else
            
            # 空文字列かどうかを判定
            if param[1].blank? == false
            
              # 複数の場合、検索に"or"と書く必要があるので、その部分を表現
              if count != 0
                query = query + "or "
              end
              
              # column名 like ? というクエリ文を作成
              query = query + "#{param[0]} like ? "
              
              # カウントアップ(0以外ならorを付けるフラグ)
              count += 1
              
              if param[1].class == Hash
                key.push "%#{param[1].values[0]}%"
              else
                # 検索キーワードを配列に追加
                key.push "%#{param[1]}%"
              end
            end
          end
        end
        # 検索クエリーとキーワードをマージ
        sql.push query
        key.each do |k|
          sql.push k
        end
        print sql
        return sql
      end
end
