class UsersController < ApplicationController
  def index
    @text = "Index"
    @users = User.all.order(created_at: :desc)
  end
end
