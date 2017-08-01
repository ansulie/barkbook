class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_user

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def require_user
        redirect_to '/login' unless current_user
    end

    def logged_in
        @logged_in = !!current_user
    end

    def require_current_user
        redirect_to current_user unless params[:id].to_i == @current_user.id.to_i
    end
end
