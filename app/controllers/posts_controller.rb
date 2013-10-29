class PostsController < ApplicationController

  def show
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize! :create, Post, message: "You need to be a member to create a new post." #authorize checks to see if 
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(params[:post]) #why is this changed from @post = Post.new(params[:post]) to  @post = current_user.posts.build(params[:post]) after implementing associations? is it because the post is now associated with a user?  it automatically assigns the id?  what is build vs new?
    @post.topic = @topic

    authorize! :create, @post, message: "You need to be signed up to do that."  #authorize! determines if user is able to do the symbole following.  
    if @post.save                               # if post was saved successfully
      flash[:notice] = "Post was saved."        # flash the notice and 
      redirect_to [@topic, @post]                         # redirect to the post page
    else                                        # if post didn't save successfully
      flash[:error] = "There was an error saving the post. Please try again." # flash the error notice
      render :new                               # render the "new" page again
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize! :edit, @post, message: "You need to own the post to edit it."
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize! :update, @post, message: "You need to own the post to edit it."
    if @post.update_attributes(params[:post])   # if post updated properly, flash notice and redirect to show post
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else                                        # if post not updated properly, flash notice with error and then re-render edit page
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end
end

