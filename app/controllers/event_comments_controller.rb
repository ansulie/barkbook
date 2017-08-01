class EventCommentsController < ApplicationController
    before_action :require_user

    def new
        @event_comment = EventComment.new
    end

    def create
        @event_comment = EventComment.new(event_comment_params)
        if @event_comment.save
            redirect_to action: 'index', controller: 'events'
        else
            render json: @event_comment.errors.full_messages
            # render :action => :new
        end
    end

    def update
        @event_comment = EventComment.find(params[:id])
        if @event_comment.update(event_comment_params)
            redirect_to action: 'index', controller: 'events'
        else
            render plain: @event_comment.errors.full_messages
        end
    end

    def destroy
        @event_comment = EventComment.find(params[:id])
        if @event_comment.destroy
            redirect_to action: 'index', controller: 'events'
        else
            render plain: @event_comment.errors.full_messages
        end
    end

    def event_comment_params
        params.require(:event_comment).permit(:content, :event_id, :user_id, :id)
    end
end
