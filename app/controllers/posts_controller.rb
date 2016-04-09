class PostsController < ApplicationController
  def show
    @text = "Show"
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def index
    @text = "Index"
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @text = "New"
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      redirect_to root_path
    end
  end

  def edit
    @text = "Edit"
  end

  def update

  end

  private
  def post_params
    params.require(:post).permit(:content, :user_id) if params[:post]
  end
end
