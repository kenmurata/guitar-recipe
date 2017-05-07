class PurchasesController < ApplicationController
    def index
        @purchases = Purchase.all.order(:id)
    end
    
    def new
        @purchase = Purchase.new
    end
    
    def edit
        @purchase = Purchase.find(params[:id])
    end
    
    def create
        @purchase = Purchase.new(purchases_params)
        if @purchase.save
            redirect_to root_path, notice: '登録成功'
        else
            redirect_to root_path, notice: '登録失敗'
        end
    end
    
    def update
        @purchase = Purchase.find(params[:id])
        if @purchase.update(purchases_params)
            redirect_to root_path, notice: '登録成功'
        else
            redirect_to root_path, notice: '登録失敗'
        end
    end
    
    private
        def purchases_params
            params.require(:purchase).permit(:user_id, :product_id)
        end
end
