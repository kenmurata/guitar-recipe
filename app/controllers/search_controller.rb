class SearchController < ApplicationController
    def index
    end
    def result
      sql = create_query(params)
      @users = User.where(sql)
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
        return sql
      end
end
