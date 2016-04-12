class PostsController < ApplicationController
  def show
    @text = "Show"
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def index
    @text = "Index"
    @posts = Post.search(params[:search]).order(created_at: :desc)
  end

  def new
    @text = "New"
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      redirect_to new_post_path
    end
  end

  def edit
    @text = "Edit"
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update post_params
      redirect_to post_path(@post)
    else
      redirect_to edit_post_path(@post)
    end
  end

  private
  def post_params
    params.require(:post).permit(:content, :user_id) if params[:post]
  end
end
