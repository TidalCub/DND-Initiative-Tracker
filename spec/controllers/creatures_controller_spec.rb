require "rails_helper"

RSpec.describe CreaturesController, type: :controller do
  
  describe "POST #create" do
    subject { post :create, params: { user_id: user.id, game_id: game.id, encounter_id: encounter.id, creature: } }

    let(:user) { create(:user) }
    let(:game) { create(:game, user: user) }
    let (:encounter) { create(:encounter, game: game) }

    let(:creature) { { name: "Goblin", health: 10, armor_class: 15, initiative: 10 } }

    before do
      sign_in user
      allow(controller).to receive(:current_user).and_return(user)
    end

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

    it "has an order" do
      subject
      expect(Creature.last.position).to eq(1)
    end
  end

  describe "POST #premade_create" do
    let(:user) { create(:user) }
    let(:game) { create(:game, user: user) }
    let (:encounter) { create(:encounter, game: game) }
    let(:monster) { create(:premade_monster) }
    
    before do
      sign_in user
      allow(controller).to receive(:current_user).and_return(user)
    end
    subject { post :premade_create, params: { user_id: user.id, game_id: game.id, encounter_id: encounter.id, monster: { id: monster.id } } }

    it "creates a new creature" do
      expect { subject }.to change(Creature, :count).by(1)
    end

    it "gets the details" do
      subject
      expect(Creature.last).to have_attributes(name: "Adult Black Dragon", health: 195, armor_class: 19)
    end
  end

  describe "DELETE #destroy" do
    let(:user) { create(:user) }
    let(:game) { create(:game, user: user) }
    let(:encounter) { create(:encounter, game: game) }
    let(:creature) { create(:creature, encounter: encounter) }

    subject { delete :destroy, params: { user_id: user.id, game_id: game.id, encounter_id: encounter.id, id: creature.id } }

    before do
      sign_in user
      creature
      allow(controller).to receive(:current_user).and_return(user)
    end
    
    it "deletes the creature" do
      expect { subject }.to change(Creature, :count).by(-1)
    end
  end
end