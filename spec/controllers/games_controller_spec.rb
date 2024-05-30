require "rails_helper"

RSpec.describe GamesController, type: :controller do
  describe "GET #index" do
    subject { get :index, params: { user_id: user.id } }
    let(:user) { create(:user)}
    let(:game) { create(:game, user: user) }


    context "when the user is signed in" do
      before do
        sign_in user
        game
      end
  
      it "assigns @games" do
        subject
        expect(assigns(:games)).to match_array(game)
      end
    end

    context "when the user is not signed in" do
      it "redirects to the sign in page" do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #show" do

  end

  describe "POST #create" do
    subject { post :create, params: { user_id: user.id, game: { name: "game1" } } }
    let(:user) { create(:user)}

    before do
      sign_in user
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
        expect(response).to redirect_to(user_game_encounters_url(user, Game.first))
      end
    end
    context "when the game is invalid" do
      let(:user) { create(:user)}
      let(:game) { build(:game, user: user) }

      before do
        allow(Game).to receive(:new).and_return(game)
        allow(game).to receive(:save).and_return(false)
      end

      it "shows a flash message" do
        subject
        expect(flash[:alert]).to eq("Game could not be created")
      end
    end
  end
end