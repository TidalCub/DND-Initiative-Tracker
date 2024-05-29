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
    @creature = Creature.new(creature_params(monster))
    @creature.encounter = Encounter.find(params[:encounter_id])
    if @creature.save
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

  def creature_params(monster)
    {name: monster["name"], health: monster["hit_points"], armor_class: monster["armor_class"].first["value"], initiative: initiative, 
    strength: monster["strength"], dexterity: monster["dexterity"], constitution: monster["constitution"], intelligence: monster["intelligence"], 
    wisdom: monster["wisdom"], charisma: monster["charisma"], size: monster["size"], monster_type: monster["type"], alignment: monster["alignment"], 
    walking_speed: monster["speed"]["walk"], fly_speed: monster["speed"]["fly"], swim_speed: monster["speed"]["swim"]}
  end

  def create_params
    params.require(:creature).permit(:name, :health, :armor_class, :initiative)
  end
end
