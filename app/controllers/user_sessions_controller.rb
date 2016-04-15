class UserSessionsController < ApplicationController
  skip_before_action :require_login
  def new
    if current_user
      redirect_to posts_path
    else
      @user = User.new
    end
  end

  def create
    if @user = login(params[:email], params[:password])
      flash[:success] = 'Login successful'
      redirect_to root_path
    else
      redirect_to new_user_session_path
      flash[:alert] = 'Login failed'
    end
  end

  def destroy
    logout
    if cookies[:_tweeter_session] && cookies["rack.session"]
      cookies.delete :_tweeter_session
      cookies.delete :"rack.session"
    end
    redirect_to login_path
    flash[:success] = 'Logged out!'
  end
end
