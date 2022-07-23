class PostsController < ApplicationController
  before_action :find_post, only: %i[show edit update destroy]

  SCOPES = %w(movies serials cartoons).freeze

  def index
    @posts = if params[:scope].present? && SCOPES.include?(params[:scope])
      Post.public_send(params[:scope])
    else
      Post.all
    end
    authorize @posts
  end

  def show; end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    authorize @post

    if @post.save
      redirect_to post_path(@post), success: 'The post has been created!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), success: 'The post has been updated!'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'The post has been deleted!'
  end

  private

  def find_post
    @post = Post.find(params[:id])
    authorize @post
  end

  def post_params
    params.require(:post).permit(:title, :body, :category, :image, :user_id)
  end
end
