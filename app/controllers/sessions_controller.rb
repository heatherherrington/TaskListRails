class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:login, :create]

  def index
    if session[:user_id].nil?
      redirect_to root_path
      return
    else
      @user = User.find(session[:user_id]) # < recalls the value set in a previous request
    end
  end

  def create
    auth_hash = request.env['omniauth.auth']
    redirect_to login_failure_path unless auth_hash['uid']

    @user = User.find_by(uid: auth_hash[:uid], provider: 'github')
    if @user.nil?
      # User doesn't match anything in the DB.
      # Attempt to create a new user.
      @user = User.build_from_github(auth_hash)
      render :creation_failure and return unless @user.save
    end

    # Save the user ID in the session
    session[:user_id] = @user.id

    redirect_to :tasks
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:logged_out] = "You are now logged out"
    end
    redirect_to root_path
  end

  def login_failure; end

  def creation_failure; end
end
