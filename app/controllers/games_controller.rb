class GamesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @games = current_user.games.all
    @new_game = Game.new
  end

  def show
  end

  def new
  end
  
  def create
    game = Game.new(create_params)
    game.user = current_user
    if game.save
      flash[:notice] = "Game created"
      redirect_to user_game_encounters_url(current_user, game)
    else
      flash[:alert] = "Game could not be created"
      redirect_to root_path
    end

  end

  private

  def create_params
    params.require(:game).permit(:name)
  end
end
