class ParkCommentsController < ApplicationController
    before_action :require_user

    def new
        @park_comment = ParkComment.new
        @redirect = params[:redirect]
    end

    def create
        @park_comment = ParkComment.new(park_comment_params)
        redirect = params[:park_comment][:redirect]
        # render json: params and return
        if @park_comment.save
            redirect_to action: 'show', controller: 'users', id: redirect
        else
            render json: @park_comment.errors.full_messages
            # render :action => :new
        end
    end

    def update
        @park_comment = ParkComment.find(params[:park_comment][:id])
        redirect = params[:park_comment][:redirect]
        if @park_comment.update(park_comment_params)
            redirect_to action: 'show', controller: 'users', id: redirect
        else
            render plain: @park_comment.errors.full_messages
        end
    end

    def destroy
        @park_comment = ParkComment.find(params[:id])
        redirect = params[:redirect]
        if @park_comment.destroy
            redirect_to action: 'show', controller: 'users', id: redirect
        else
            render plain: @park_comment.errors.full_messages
        end
    end

    private

    def park_comment_params
        params.require(:park_comment).permit(:content, :user_id, :park_id, :id)
    end
end
