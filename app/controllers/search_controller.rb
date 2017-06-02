class SearchController < ApplicationController
    def index
    end
    def result
      sql = create_query(params)
      @users = User.where(sql)
      #@users = User.where('name = ? or email = ?', params[:name], params[:email])
    end
    
    private
      def create_query(params)
        sql = []
        key = []
        query = ""
        count = 0
        params.each do |param|
          if param[0] == "utf8" || param[0] == "commit" || param[0] == "controller" || param[0] == "action"
          else
            if count != 0
              query = query + "or "
            end
            query = query + "#{param[0]} like ? "
            count += 1
            key.push "%#{param[1]}%"
          end
        end
        sql.push query
        key.each do |k|
          sql.push k
        end
        return sql
      end
end
