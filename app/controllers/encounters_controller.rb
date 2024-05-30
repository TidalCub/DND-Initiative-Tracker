class EncountersController < ApplicationController
  def index
    @game = current_user.games.find(params[:game_id])
    @encounter = @game.encounters.all
    @new_encounter = Encounter.new
  end

  def show
    @encounter = current_user.games.find(params[:game_id]).encounters.find(params[:id])
    @new_creature = Creature.new
  end

  def create
    @encounter = Encounter.new(create_params)
    @encounter.game = Game.find(params[:game_id])
    if @encounter.save
      redirect_to user_game_encounters_url(current_user, params[:game_id])
    end
  end

  def update
    @encounter = current_user.games.find(params[:game_id]).encounters.find(params[:id])
    if params[:encounter][:action] == "next"
      @encounter.current_turn += 1
    end
    @encounter.save
  end

  private

  def create_params
    params.require(:encounter).permit(:name)
  end
end
