class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_community
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = @community.posts.order(created_at: :desc)  
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = @community.posts.new
  end

  # GET /posts/1/edit
  def edit
    authorize_user!
  end

  # POST /posts or /posts.json
  def create
    @post = @community.posts.new(post_params)
    @post.user = current_user
      if @post.save
        redirect_to [@community, @post], notice: "Publicación creada exitosamente"
      else
        render :new
      end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    authorize_user!
      if @post.update(post_params)
        redirect_to [@community, @post], notice: "Publicación actualizada exitosamente."
      else
        render :edit
      end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    authorize_user!
    @post.destroy!
    redirect_to @community, notice: "Publicación eliminada exitosamente."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = @community.posts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.expect(post: [ :content, :user_id, :community_id ])
    end

    def set_community
      @community = Community.find(params[:community_id])
    end

    def authorize_user!
      unless current_user == @post.user
        redirect_to @community, alert: "No tienes permisos para realizar esta acción."
      end
    end
end
