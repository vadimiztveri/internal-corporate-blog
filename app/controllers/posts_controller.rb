class PostsController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        authorize! :index, Post

        @posts = Post
          .published
          .ordered_by_created_at_desc
          .paginate(:page => params[:page], :per_page => 10)
      end
      format.rss do
        @current_user = User.find_by :single_access_token => params[:token], :active => true
        authorize! :rss, Post

        @posts = Post
          .published
          .ordered_by_created_at_desc
          .paginate(:page => params[:page], :per_page => 10)
      end
    end
  end

  def new
    @post = Post.new
    authorize! :new, @post
    @post.user_id = current_user.id
  end

  def create
    @post = Post.new(post_params)
    authorize! :new, @post
    @post.user_id = current_user.id

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

	def show
    @post = Post.find(params[:id])
    authorize! :index, @post
	end

	def edit
	  @post = Post.find(params[:id])
    authorize! :edit, @post
	end

	def update
	  @post = Post.find(params[:id])
    authorize! :edit, @post

    if @post.update(post_params)
	    redirect_to @post
	  else
	    render 'edit'
	  end
	end

	def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @post.destroy

    redirect_to posts_path
  end


  private

  def post_params
    params.require(:post).permit(:title, :text, :published)
  end
end
