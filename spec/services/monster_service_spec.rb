require "rails_helper"

RSpec.describe MonsterService do
  describe ".fetch_all_monsters" do
    it "returns a aray of monsters" do
      VCR.use_cassette("all_monsters") do
        monsters = MonsterService.fetch_all_monsters
        expect(monsters).to be_an(Array)
      end
    end
  end
end