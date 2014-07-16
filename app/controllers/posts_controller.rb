class PostsController < ApplicationController


  def show
  	@topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
  end #show

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end #new

  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.new(params.require(:post).permit(:title, :body))
    @post = current_user.posts.build(post_params)
      authorize @post
    #raise # this will short-circuit the method
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end # create 

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end #edit 

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
      authorize @post
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end#update 

  def post_params
  params.require(:post).permit(:title, :body)
  end
end


