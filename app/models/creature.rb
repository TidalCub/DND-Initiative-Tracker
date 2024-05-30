class Creature < ApplicationRecord
  belongs_to :encounter
  after_create :order

  def order
    self.encounter.creatures.order(:initiative).each_with_index do |creature, index|
      creature.update(position: index + 1)
    end
  end

end
