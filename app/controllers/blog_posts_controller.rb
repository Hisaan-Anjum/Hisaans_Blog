class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
    before_action :uc, only: [:edit, :update, :destroy]


  # GET /blog_posts
  # GET /blog_posts.json
  def index
    @blog_posts = BlogPost.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
  end

  # GET /blog_posts/1
  # GET /blog_posts/1.json
  def show
  end

  # GET /blog_posts/new
  def new
    @blog_post = current_user.blog_posts.build
  
  end


  def upvote
  @blog_post = BlogPost.find(params[:id])
  @blog_post.upvote_by current_user
  redirect_to blog_post_path
end

def downvote
  @blog_post = BlogPost.find(params[:id])
  @blog_post.downvote_by current_user
  redirect_to blog_post_path
end

  # GET /blog_posts/1/edit
  def edit
  end

  # POST /blog_posts
  # POST /blog_posts.json
  def create

    @blog_post = current_user.blog_posts.build(blog_post_params)

    respond_to do |format|
      if @blog_post.save
        format.html { redirect_to @blog_post, notice: 'Blog post was successfully created.' }
        format.json { render :show, status: :created, location: @blog_post }
      else
        format.html { render :new }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
    

  end

  # PATCH/PUT /blog_posts/1
  # PATCH/PUT /blog_posts/1.json
  def update
    respond_to do |format|
      if @blog_post.update(blog_post_params)
        format.html { redirect_to @blog_post, notice: 'Blog post was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog_post }
      else
        format.html { render :edit }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog_posts/1
  # DELETE /blog_posts/1.json
  def destroy
    @blog_post.destroy
    respond_to do |format|
      format.html { redirect_to blog_posts_url, notice: 'Blog post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  


     def uc
      @blog_post = BlogPost.find(params[:id])
      redirect_to posts_path,notice:"This is another Hisaan's post you are not allowed to edit it ."  if @blog_post.nil?
    end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog_post
      @blog_post = BlogPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_post_params
      params.require(:blog_post).permit(:post, :title)
    end
end
