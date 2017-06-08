class EventsController < ApplicationController
    def index
        @events = Event.all
    end
    
    def new
        @event = Event.new
    end
    
    def create
        @event = Event.new(event_params)
        if @event.save
            redirect_to root_path, notice: '登録成功'
        else
            redirect_to root_path, notice: '登録失敗'
        end
    end
    
    def update
    end
    
    def destroy
    end
    
    private
      def event_params
          params.require(:event).permit(:name,:category,:price,:add_price,:day,:expense,:income)
      end
end
