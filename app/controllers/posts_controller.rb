class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]

  # GET /posts
  def index
    ActiveRecord::Base.connected_to(role: :reading) do
      @q = Post.all.includes(:user).order(:created_at).reverse_order.ransack(params[:q])
      @pagy, @posts = pagy(@q.result, items: 10, page: @page)
    end
  end

  # GET /posts/1
  def show
    ActiveRecord::Base.connected_to(role: :reading) do
      @post = Post.includes(comments: :user).find(params[:id])
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to post_path(@post), success: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to post_path(@post), success: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      ActiveRecord::Base.connected_to(role: :reading) do
        @post = Post.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end
end
