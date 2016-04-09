class CommentsController < ApplicationController

  def new
    @text = "New"
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save!
      redirect_to post_path(@comment.post)
    else
      redirect_to post_path(@comment.post)
    end
  end

  def edit
    @text = "Edit"
  end

  def update

  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id) if params[:comment]
  end
end
