class PollsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_community
  before_action :set_poll, only: %i[show edit update destroy results]

  def index
    @polls = @community.polls.order(created_at: :desc)
  end

  def show
    @options = @poll.options
    @user_voted = @poll.votes.exists?(user: current_user)
  end

  def new
    @poll = @community.polls.new
    5.times { @poll.options.build } # Inicializa con 5 opciones vacías
  end

  def create
    @poll = @community.polls.new(poll_params)
    @poll.user = current_user
    if @poll.save
      redirect_to @community, notice: "Encuesta creada exitosamente."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @poll.update(poll_params)
      redirect_to @community, notice: "Encuesta actualizada exitosamente."
    else
      render :edit
    end
  end

  def destroy
    if @poll.user == current_user
      @poll.destroy
      redirect_to @community, notice: "Encuesta eliminada exitosamente."
    else
      redirect_to @community, alert: "No tienes permiso para eliminar esta encuesta."
    end
  end
  def results
  end

  private

  def set_community
    @community = Community.find(params[:community_id])
  end

  def set_poll
    @poll = @community.polls.find(params[:id])
  end

  def poll_params
    params.require(:poll).permit(:title, :end_time, options_attributes: [ :id, :title, :_destroy ])
  end
end
