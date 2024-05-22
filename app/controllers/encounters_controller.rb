class EncountersController < ApplicationController
  def index
    @encounter = current_user.games.find(params[:game_id]).encounters.all
  end
  
  def show
  end

  def create
    @encounter = Encounter.new(create_params)
    @encounter.game = Game.find(params[:game_id])
    @encounter.save
  end

  private

  def create_params
    params.require(:encounter).permit(:name)
  end
end
