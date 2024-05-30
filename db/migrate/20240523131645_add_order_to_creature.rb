class AddOrderToCreature < ActiveRecord::Migration[7.1]
  def change
    add_column :creatures, :position, :integer
    add_column :encounters, :current_turn, :integer
  end
end
