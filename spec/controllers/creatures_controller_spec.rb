require "rails_helper"

RSpec.describe CreaturesController, type: :controller do
  describe "POST #create" do
    subject { post :create, params: { user_id: user.id, game_id: game.id, encounter_id: encounter.id, creature: } }

    let(:user) { create(:user) }
    let(:game) { create(:game, user: user) }
    let (:encounter) { create(:encounter, game: game) }

    let(:creature) { { name: "Goblin", health: 10, armor_class: 15, initiative: 10 } }

    it "creates a new creature" do
      expect { subject }.to change(Creature, :count).by(1)
    end

    it "belongs to a encounter" do
      subject
      expect(Creature.last.encounter).to eq(encounter)
    end

    it "has all the stats" do
      subject
      expect(Creature.last).to have_attributes(creature)
    end
  end
end