class ChangeEncounterTable < ActiveRecord::Migration[7.1]
  def change
    add_column :encounters, :name, :string
    add_reference :encounters, :game, foreign_key: true
  end
end
