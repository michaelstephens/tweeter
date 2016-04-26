class BlogsController < ApplicationController
  def show
    @text = "Show"
    @blog = Blog.find(params[:id])
  end

  def index
    @text = "Index"
    @blogs = Blog.filter(params[:filter]).order(created_at: :desc).page(params[:page])
  end

  def new
    @text = "New"
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to blog_path(@blog)
      flash[:success] = "Blog was created!"
    else
      redirect_to new_blog_path
      flash[:error] = @blog.errors.messages.map{|e| "<i class='fa fa-minus'></i> <strong>#{e.flatten.first.to_s.titleize}</strong> #{e.flatten.last}"}.join('<br />')
    end
  end

  def edit
    @text = "Edit"
    @blog = Blog.find(params[:id])
    check_authorization(@blog)
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update blog_params
      redirect_to blog_path(@blog)
      flash[:success] = "Blog was saved!"
    else
      redirect_to edit_blog_path(@blog)
      flash[:error] = @blog.errors.messages.map{|e| "<i class='fa fa-minus'></i> <strong>#{e.flatten.first.to_s.titleize}</strong> #{e.flatten.last}"}.join('<br />')
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    if check_authorization(@blog)
      @blog.destroy
      redirect_to root_path
      flash[:success] = "Blog was destroyed!"
    end
  end

  private
  def blog_params
    if params[:blog]
      params[:blog][:user_id] = current_user.id
      params.require(:blog).permit(:content, :tags, :user_id)
    end
  end

  def check_authorization(blog)
    unless blog.user == current_user
      redirect_to root_path
      flash[:alert] = "Not Authorized"
      return false
    else
      return true
    end
  end
end
