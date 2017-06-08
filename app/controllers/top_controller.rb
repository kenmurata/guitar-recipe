class TopController < ApplicationController
    def index
        @users_num = User.count
        @products_num = Product.count
        @events_num = Event.count
    end
end
