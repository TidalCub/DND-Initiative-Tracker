class Creature < ApplicationRecord
  belongs_to :encounter
  after_create :order

  def order
    self.encounter.creatures.order(initiative: :desc ).each_with_index do |creature, index|
      creature.update(position: index + 1)
    end
  end

  def current_turn?
    self.position == self.encounter.current_turn
  end
end
