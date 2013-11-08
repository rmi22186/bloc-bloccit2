class CommentsController < ApplicationController
  respond_to :html, :js

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build(params[:comment])
    @comment.post = @post

    authorize! :create, @comment, message: "You need be signed in to do that."
    
    if @comment.save
      flash[:notice] = "Comment was created."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render 'topics/posts/show'
    end 
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    @comment = @post.comments.find(params[:id])
    authorize! :destroy, @comment, message: "You need to own the comment to delete it."
    
    if @comment.destroy
      flash[:notice] = "Comment was removed successfully."
    else
      flash[:error] = "Comment couldn't be deleted."
    end

    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end
  end
end