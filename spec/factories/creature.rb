require 'faker'

FactoryBot.define do
  factory :creature do
    name { Faker::Fantasy::Tolkien.character}
    health { Faker::Number.between(from: 1, to: 100) }
    armor_class { Faker::Number.between(from: 1, to: 20) }
    initiative { Faker::Number.between(from: 1, to: 20) }
    encounter
  end
end
