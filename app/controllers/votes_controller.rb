class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_community
  before_action :set_poll

  def create
    @vote = @poll.votes.new(vote_params)
    @vote.user = current_user
    if @vote.save
      redirect_to community_poll_path(@community, @poll), notice: "Voto registrado exitosamente."
    else
      redirect_to community_poll_path(@community, @poll), alert: "No se pudo registrar el voto."
    end
  end

  private

  def set_community
    @community = Community.find(params[:community_id])
  end

  def set_poll
    @poll = @community.polls.find(params[:poll_id])
  end

  def vote_params
    params.require(:vote).permit(:option_id)
  end
end