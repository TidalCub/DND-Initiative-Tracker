class AddDefualtPositionToEncounter < ActiveRecord::Migration[7.1]
  def change
    change_column :encounters, :current_turn, :integer, default: 1
  end
end
