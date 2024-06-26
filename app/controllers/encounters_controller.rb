class EncountersController < ApplicationController
  before_action :authenticate_user!

  def index
    @game = current_user.games.find(params[:game_id])
    @encounter = @game.encounters.all
    @new_encounter = Encounter.new
  end

  def show
    @encounter = current_user.games.find(params[:game_id]).encounters.find(params[:id])
    creaturs = previous_upcomming_turns(@encounter)
    @past_turns = creaturs[0]
    @upcoming_turns = creaturs[1]
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
    @encounter.current_turn = @encounter.current_turn.to_i + 1
    if @encounter.current_turn > @encounter.creatures.count
      @encounter.current_turn = 1
    end
    @encounter.save
    redirect_back(fallback_location: root_path)

  end

  def minimal_turns
    @encounter = current_user.games.find(params[:game_id]).encounters.find(params[:encounter_id])
    creaturs = previous_upcomming_turns(@encounter)
    @past_turns = creaturs[0]
    @upcoming_turns = creaturs[1]
    render layout: false
  end

  private

  def previous_upcomming_turns(encounter)
    creatures = encounter.creatures.order(:position)
    index = creatures.index { |creature| creature.position == encounter.current_turn }
    if creatures.count > 2
      past_turns = creatures[0...index]
      upcoming_turns = creatures[index+1..-1]
    
      while (upcoming_turns.size - past_turns.size).abs > 1
        if upcoming_turns.size > past_turns.size
          past_turns.unshift(upcoming_turns.pop)
        elsif past_turns.size > upcoming_turns.size
          upcoming_turns.push(past_turns.shift)
        end
      end
    end
  
    [past_turns, upcoming_turns]
  end

  def create_params
    params.require(:encounter).permit(:name)
  end
end
