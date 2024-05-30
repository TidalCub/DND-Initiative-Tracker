require "rails_helper"

RSpec.describe EncountersController, type: :controller do
  describe "GET #index" do
    subject { get :index, params: {user_id: user.id, game_id: game.id} }
      let(:user) { create(:user)}
      let(:game) { create(:game, user: user) }
      

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    context "when there is an encounter in the game" do
      let(:encounter) { create(:encounter, game: game) }
      before do 
        encounter
      end

      it "assigns @encounters" do
        subject
        expect(assigns(:encounter)).to match_array(encounter)
      end
    end

    context "when there is not an encounter in the game" do
      it "assigns @encounters" do
        subject
        expect(assigns(:encounter)).to eq([])
      end
    end
  end

  describe "GET #show" do
    subject { get :show, params: {user_id: user.id, game_id: game.id, id: encounter.id} }
    let(:user) { create(:user)}
    let(:game) { create(:game, user: user) }
    let(:encounter) { create(:encounter, game: game) }
    let(:creature) { create(:creature, encounter: encounter) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
      creature
    end

    it "shows all the creatures in the encounter" do
      subject
      expect(assigns(:encounter).creatures).to match_array(creature)
    end
  end

  describe "POST #create" do
    subject { post :create, params: {user_id: user.id, game_id: game.id, encounter: {name: "encounter1"} } }
    let(:user) { create(:user)}
    let(:game) { create(:game, user: user) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end
    it "creates a new encounter" do
      expect { subject }.to change { Encounter.count }.by(1)
    end
    it "belongs to a game" do
      subject
      expect(Encounter.first.game).to eq(game)
    end
    it "belongs to a user" do
      subject
      expect(Encounter.first.game.user).to eq(user)
    end
    it "has a name" do
      subject
      expect(Encounter.first.name).to eq("encounter1")
    end
    
  end 
  describe "PATCH #update" do
    let(:user) { create(:user)}
    let(:game) { create(:game, user: user) }
    let(:encounter) { create(:encounter, game: game, current_turn: 1) }
    let(:creature) { create_list(:creature, 3, encounter: encounter) }

    subject { patch :update, params: {user_id: user.id, game_id: game.id, id: encounter.id, encounter: {action: "next"} } }

    before do
      creature
      allow(controller).to receive(:current_user).and_return(user)
    end

    context "next turn" do
      it "changes the current turn" do
        subject
        expect(Encounter.last.current_turn).to eq(2)
      end

      it "resets the current turn if it is greater than the number of creatures" do
        encounter.update(current_turn: 3)
        subject
        expect(Encounter.last.current_turn).to eq(1)
      end
    end
  end
end