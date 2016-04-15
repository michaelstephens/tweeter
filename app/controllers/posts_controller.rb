class PostsController < ApplicationController
  def show
    @text = "Show"
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def index
    @text = "Index"
    @posts = Post.search(params[:search]).order(created_at: :desc).page(params[:page])
  end

  def new
    @text = "New"
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post)
      flash[:success] = "Post was created!"
    else
      redirect_to new_post_path
      flash[:error] = @post.errors.messages.map{|e| "<i class='fa fa-minus'></i> <strong>#{e.flatten.first.to_s.titleize}</strong> #{e.flatten.last}"}.join('<br />')
    end
  end

  def edit
    @text = "Edit"
    @post = Post.find(params[:id])
    check_authorization(@post)
  end

  def update
    @post = Post.find(params[:id])
    if @post.update post_params
      redirect_to post_path(@post)
      flash[:success] = "Post was saved!"
    else
      redirect_to edit_post_path(@post)
      flash[:error] = @post.errors.messages.map{|e| "<i class='fa fa-minus'></i> <strong>#{e.flatten.first.to_s.titleize}</strong> #{e.flatten.last}"}.join('<br />')
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if check_authorization(@post)
      @post.destroy
      redirect_to root_path
      flash[:success] = "Post was destroyed!"
    end
  end

  private
  def post_params
    if params[:post]
      params[:post][:user_id] = current_user.id
      params.require(:post).permit(:content, :user_id)
    end
  end

  def check_authorization(post)
    unless post.user == current_user
      redirect_to root_path
      flash[:alert] = "Not Authorized"
      return false
    else
      return true
    end
  end
end
