class CommunitiesController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :set_community, only: %i[ show edit update destroy metrics]
  
  # Agregado Luis Inga
  def metrics
    @events_count = @community.events_count
    @posts_count = @community.posts_count
    @total_attendees_count = @community.total_attendees_count
    @average_attendees = @community.average_attendees_per_event

    respond_to do |format|
      format.html # Renderiza app/views/communities/metrics.html.erb
      format.json { render json: metrics_data }
    end
  end

  # GET /communities or /communities.json
  def index
    @communities = Community.all
  end

  # GET /communities/1 or /communities/1.json
  def show
    @events = @community.events.order(date: :asc)
    @posts = @community.posts.order(created_at: :desc)
    @polls = @community.polls.order(created_at: :desc)# agregado César
    @post = @community.posts.new if user_signed_in?
    @poll = @community.polls.new if user_signed_in?# agregado César
  end

  # GET /communities/new
  def new
    @community = Community.new
  end

  # GET /communities/1/edit
  def edit
  end

  # POST /communities or /communities.json
  def create
    @community = Community.new(community_params)
    @community.user = current_user

      if @community.save
        redirect_to @community, notice: "Comunidad fue creada exitosamente."
      else
        render :new 
      end
  end

  # PATCH/PUT /communities/1 or /communities/1.json
  def update
      if @community.update(community_params)
        redirect_to @community, notice: "Comunidad fue actualizada exitosamente."
      else
        render :edit
      end
  end

  # DELETE /communities/1 or /communities/1.json
  def destroy
    @community.destroy!
    redirect_to @community, notice: "Comunidad fue eliminada exitosamente."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community
      @community = Community.find(params.expect(:id))
    end
  
    # Agregado Luis Inga
    def metrics_data
    {
      events_count: @events_count,
      posts_count: @posts_count,
      total_attendees_count: @total_attendees_count,
      average_attendees: @average_attendees
    }
  end

    # Only allow a list of trusted parameters through.
    def community_params
      params.expect(community: [ :name, :description, :user_id ])
    end
end
