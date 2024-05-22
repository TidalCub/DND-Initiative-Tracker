require "rails_helper"

RSpec.describe EncountersController, type: :controller do
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
end