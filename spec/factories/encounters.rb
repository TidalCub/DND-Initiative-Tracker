FactoryBot.define do
  factory :encounter do
    name { Faker::Fantasy::Tolkien.location }
    game
  end
end
