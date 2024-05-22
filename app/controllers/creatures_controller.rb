class CreaturesController < ApplicationController
  def create
    @creature = Creature.new(create_params)
    @creature.encounter = Encounter.find(params[:encounter_id])
    @creature.save
  end

  private 

  def create_params
    params.require(:creature).permit(:name, :health, :armor_class, :initiative)
  end
end
