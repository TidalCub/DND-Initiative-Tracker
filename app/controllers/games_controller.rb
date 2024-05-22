class GamesController < ApplicationController
  def index
    @games = current_user.games.all
  end

  def show
  end

  def create
    game = Game.new(create_params)
    game.user = current_user
    if game.save
      flash[:notice] = "Game created"
      redirect_to user_game_url(current_user, game)
    else
      flash[:alert] = "Game could not be created"
      render :new
    end

  end

  private

  def create_params
    params.require(:game).permit(:name)
  end
end
