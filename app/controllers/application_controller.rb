class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  private

  def current_user
    begin
      @current_user ||= User.find_by(id: session[:user_id])
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in"
      redirect_to root_path
    end
  end

  helper_method :current_user
end
