class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_community
  before_action :set_event, only: %i[ show edit update destroy join leave ]

  def join
    @event.attendees << current_user unless @event.attendees.include?(current_user)
    redirect_to @event, notice: 'Te has unido al evento.'
  end

  def leave
    @event.attendees.delete(current_user)
    redirect_to @community, notice: 'Has abandonado el evento.'
  end

  # GET /events or /events.json
  def index
    @events = @community.events.order(date: :asc) 
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = @community.events.new
  end

  # GET /events/1/edit
  def edit
    authorize_user!
  end

  # POST /events or /events.json
  def create
    @event = @community.events.new(event_params)
    @event.user = current_user
      if @event.save
        redirect_to @community, notice: "Evento creado exitosamente."
      else
        render :new
      end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    authorize_user!
      if @event.update(event_params)
        redirect_to @community, notice: "Evento actualizado exitosamente."
      else
        render :edit
      end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    authorize_user!
    @event.destroy!
    redirect_to @community, notice: "Evento eliminado exitosamente"
  end

  private

   def set_community
      @community = Community.find(params[:community_id])
    end
 
    def set_event
      @event = @community.events.find(params[:id])
    end

    def event_params
      params.expect(event: [ :name, :description, :date, :user_id, :community_id ])
    end

    def authorize_user!
      unless current_user == @event.user
        redirect_to @community, alert: 'No puedes editar o eliminar un evento que no creaste.'
      end
    end
end
