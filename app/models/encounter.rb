class Encounter < ApplicationRecord
  belongs_to :game
  has_many :creatures

  def re_order
    creatures.order(initiative: :desc ).each_with_index do |creature, index|
      creature.update(position: index + 1)
    end
  end
end
