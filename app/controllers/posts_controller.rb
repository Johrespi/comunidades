class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.community_id = params[:community_id]
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user
      if @post.save
        redirect_to @post, notice: "Publicación creada exitosamente"
      else
        render :new
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
      if @post.update(post_params)
        redirect_to @post, notice: "Publicación actualizada exitosamente."
      else
        render :edit
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!
    redirect_to posts_url, notice: "Publicación eliminada exitosamente."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.expect(post: [ :content, :user_id, :community_id ])
    end
end
