require 'net/http'
require 'json'

class CreaturesController < ApplicationController
  def create
    @creature = Creature.new(create_params)
    @creature.encounter = Encounter.find(params[:encounter_id])
    if @creature.save
      redirect_to user_game_encounter_url(current_user, params[:game_id], params[:encounter_id])
    end
  end

  def premade_create
    monster = MonsterService.fetch_monsters(params[:monster][:id])
    @creature = Creature.new(name: monster["name"], health: monster["hit_points"], armor_class: monster["armor_class"].first["value"], initiative: initiative)
    @creature.encounter = Encounter.find(params[:encounter_id])
    if @creature.save
      redirect_to user_game_encounter_url(current_user, params[:game_id], params[:encounter_id])
    else
      redirect_to user_game_encounter_url(current_user, params[:game_id], params[:encounter_id])
    end
  end

  def destroy
    @creature = Creature.find(params[:id])
    if @creature.destroy
      redirect_to user_game_encounter_url(current_user, params[:game_id], params[:encounter_id])
    end
  end
  private 

  def initiative
    rand(1..20)
  end

  def create_params
    params.require(:creature).permit(:name, :health, :armor_class, :initiative)
  end
end
