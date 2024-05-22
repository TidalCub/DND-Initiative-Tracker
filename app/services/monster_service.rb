class MonsterService
  require 'net/http'
  require 'json'
  URI_BASE = URI("https://www.dnd5eapi.co/api/monsters")

  def self.fetch_all_monsters
    response = Net::HTTP.get(URI_BASE)
    monsters = JSON.parse(response)["results"]
    monsters
  end

  def self.fetch_monsters(monster)
    response = Net::HTTP.get(URI("#{URI_BASE}/#{monster}"))
    monsters = JSON.parse(response)
    monsters
  end
end