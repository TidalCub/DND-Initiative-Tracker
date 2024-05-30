require "rails_helper"

RSpec.describe Creature, type: :model do
  describe "#order" do
    let(:user) { create(:user) }
    let(:game) { create(:game, user: user) }
    let(:encounter) { create(:encounter, game: game) }
    let(:creature1) { create(:creature, encounter: encounter, initiative: 18, position: 1 ) }
    let(:creature2) { create(:creature, encounter: encounter, initiative: 10) }

    it "orders creatures by initiative" do
      creature2.update(initiative: 20)
      expect(creature1.reload.position).to eq(2)
    end
  end
  describe "#current_turn?" do
    let(:user) { create(:user) }
    let(:game) { create(:game, user: user) }
    let(:encounter) { create(:encounter, game: game) }
    let(:creature1) { create(:creature, encounter: encounter, initiative: 18, position: 1 ) }
    let(:creature2) { create(:creature, encounter: encounter, initiative: 10) }

    it "returns true if creature is in current turn" do
      encounter.update(current_turn: 1)
      expect(creature1.current_turn?).to eq(true)
    end

    it "returns false if creature is not in current turn" do
      encounter.update(current_turn: 2)
      expect(creature1.current_turn?).to eq(false)
    end
  end
end