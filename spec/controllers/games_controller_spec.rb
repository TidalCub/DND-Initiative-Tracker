require "rails_helper"

RSpec.describe GamesController, type: :controller do
  describe "GET #index" do
    subject { get :index, params: { user_id: user.id } }
    let(:user) { create(:user)}
    let(:game) { create(:game, user: user) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
      game
    end

    it "assigns @games" do
      subject
      expect(assigns(:games)).to match_array(game)
    end
  end

  describe "GET #show" do

  end
  describe "POST #create" do
    subject { post :create, params: { user_id: user.id, game: { name: "game1" } } }
    let(:user) { create(:user)}

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    context "when the game is valid" do
      it "creates a new game" do
        subject
        expect(Game.count).to eq(1)
      end
  
      it "the game belongs to a user" do
        subject
        expect(Game.first.user).to eq(user)
      end

      it "shows a flash message" do
        subject
        expect(flash[:notice]).to eq("Game created")
      end

      it "redirects to the game show page" do
        subject
        expect(response).to redirect_to(user_game_url(user, Game.first))
      end
    end
  end
end