class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]

  def index
    @text = "Index"
    @users = User.search(params[:search]).order(created_at: :desc).page(params[:page])
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(user_params[:email], user_params[:password])
      redirect_to root_path
      flash[:success] = "User was created!"
    else
      redirect_to new_user_path
      flash[:error] = @user.errors.messages.map{|e| "<i class='fa fa-minus'></i> <strong>#{e.flatten.first.to_s.titleize}</strong> #{e.flatten.last}"}.join('<br />')
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :first_name, :last_name, :password, :password_confirmation) if params[:user]
  end
end
