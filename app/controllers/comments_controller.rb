class CommentsController < ApplicationController

  def new
    @text = "New"
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save!
      redirect_to post_path(@comment.post)
      flash[:success] = "Comment was created!"
    else
      redirect_to post_path(@comment.post)
      flash[:error] = @comment.errors.messages.map{|e| "<i class='fa fa-minus'></i> <strong>#{e.flatten.first.to_s.titleize}</strong> #{e.flatten.last}"}.join('<br />')
    end
  end

  def edit
    @text = "Edit"
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update comment_params
      redirect_to post_path(@comment.post)
      flash[:success] = "Comment was saved!"
    else
      flash[:error] = @comment.errors.messages.map{|e| "<i class='fa fa-minus'></i> <strong>#{e.flatten.first.to_s.titleize}</strong> #{e.flatten.last}"}.join('<br />')
      redirect_to edit_comment_path(@comment)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    post = @comment.post
    @comment.destroy
    redirect_to post_path(post)
    flash[:success] = "Comment was destroyed!"
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id) if params[:comment]
  end
end
