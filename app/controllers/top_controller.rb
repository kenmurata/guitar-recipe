class TopController < ApplicationController
    def index
        @users_num = User.count
        @products_num = Product.count
    end
end
