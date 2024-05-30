class ImportMonsterService
  def self.import
    MonsterService.fetch_all_monsters.each do |monster|
      monster = MonsterService.fetch_monsters(monster["index"])
      PremadeMonster.new(
        name: monster["name"],
        health: monster["hit_points"],
        armor_class: monster["armor_class"],
        strength: monster["strength"],
        dexterity: monster["dexterity"],
        constitution: monster["constitution"],
        intelligence: monster["intelligence"],
        wisdom: monster["wisdom"],
        charisma: monster["charisma"],
        size: monster["size"],
        monster_type: monster["type"],
        alignment: monster["alignment"],
        walking_speed: monster["speed"]["walk"],
        fly_speed: monster["speed"]["fly"],
        swim_speed: monster["speed"]["swim"]
      ).save
    end
  end
end