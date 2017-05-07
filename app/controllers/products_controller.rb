class ProductsController < ApplicationController
    def index
        @products = Product.all.order(:id)
    end
    
    def new
        @product = Product.new
    end
    
    def edit
        @product = Product.find(params[:id])
    end
    
    def create
        @product = Product.new(products_params)
        if @product.save
            redirect_to products_path, notice: '登録成功'
        else
            redirect_to products_path, notice: '登録失敗'
        end
    end
    
    def update
        @product = Product.find(params[:id])
        if @product.update(products_params)
            redirect_to products_path, notice: '登録成功'
        else
            redirect_to products_path, notice: '登録失敗'
        end
    end
    
    private
        def products_params
            params.require(:product).permit(:name, :price)
        end
end


