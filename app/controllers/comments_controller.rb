class CommentsController < ApplicationController
  def new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    post = Post.find(params[:post_id])
    @comment.post_id = post.id
    if @comment.save
      redirect_to post_url(post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      redirect_to post_url(post)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
