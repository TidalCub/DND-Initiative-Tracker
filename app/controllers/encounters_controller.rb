class EncountersController < ApplicationController
  def index
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
