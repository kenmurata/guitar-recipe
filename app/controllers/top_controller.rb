class TopController < ApplicationController
    def index
    end
    
    def alldelete
        User.delete_all
        Product.delete_all
        Purchase.delete_all
        redirect_to root_path, notice: '全件削除を実行しました'
    end
end
