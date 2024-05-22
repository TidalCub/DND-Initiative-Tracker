class CreaturesController < ApplicationController
  def create
    @creature = Creature.new(create_params)
    @creature.encounter = Encounter.find(params[:encounter_id])
    if @creature.save
      redirect_to user_game_encounter_url(current_user, params[:game_id], params[:encounter_id])
    end
  end

  private 

  def create_params
    params.require(:creature).permit(:name, :health, :armor_class, :initiative)
  end
end
