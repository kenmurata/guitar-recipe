class SearchController < ApplicationController
    def index
    end
    def result
      #@users = User.find_by(params)
      @users = User.find_by(name: "#{params[:name]}", email: "#{params[:email]}")
    end
end
