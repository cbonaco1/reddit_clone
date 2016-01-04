class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    #params[:post][:sub_ids].map!(&:to_i)
    # fail

    #Sub.find_by_ids(params[:post][:session_ids])
    if @post.save
      redirect_to subs_url
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
  end

  private
  def post_params
    params[:post][:sub_ids] ||= []
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
