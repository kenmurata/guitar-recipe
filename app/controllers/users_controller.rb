class UsersController < ApplicationController
    def index
        @users = User.all.order(:id)
    end
    
    def new
        @user = User.new
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def create
        @user = User.new(users_params)
        if @user.save
            redirect_to users_path, notice: '登録成功'
        else
            redirect_to users_path, notice: '登録失敗'
        end
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update(users_params)
            redirect_to users_path, notice: '登録成功'
        else
            redirect_to users_path, notice: '登録失敗'
        end
    end
    
    def history
        @user = User.find(params[:id])
        @products = Product.all.order(:id)
        @purchases = Purchase.where(user_id: @user.id)
    end
    
    private
        def users_params
            params.require(:user).permit(:name, :email)
        end
    
end