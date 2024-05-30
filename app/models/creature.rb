class Creature < ApplicationRecord
  belongs_to :encounter
  after_create :order

  def order
    encounter.re_order
  end

  def current_turn?
    self.position == self.encounter.current_turn
  end
end
