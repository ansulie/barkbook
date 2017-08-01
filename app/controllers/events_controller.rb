class EventsController < ApplicationController
    before_action :require_user
    before_action :logged_in, only: [:index, :show, :new, :update]

    def index
        user = User.find(session[:user_id])
        @events = {}
        @events[:user_events] = user.events
        @events[:user_friends_events] = []

        user.friends.try(:each) do |x|
            @events[:user_friends_events].push(x.try(:events))
        end
    end

    def show
        #going to use this off calander if there's time
        render plain: 'event'
    end

    def new
        @event = Event.new
    end

    def create
        # post to make new event
        @event = Event.new(event_params)
        if @event.save
            redirect_to action: "index"
        else
            render :action => :new
        end
    end

    def update
        @event = Event.find(params[:event][:event_id])
        if @event.update(event_params)
            redirect_to action: "index"
        else
            render plain: "update failed"
        end
    end

    def destroy
        @event = Event.find(params[:id])
        if @event.destroy
          redirect_to action: 'index'
        else
            render plain: "couldn't delete"
        end
    end
    def event_params
      params.require(:event).permit(:name, :location, :event_date, :user_id)
    end

    def month_calendar
    end
end
