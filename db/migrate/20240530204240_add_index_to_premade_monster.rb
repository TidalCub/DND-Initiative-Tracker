class AddIndexToPremadeMonster < ActiveRecord::Migration[7.1]
  def change
    add_column :premade_monsters, :index, :string
    add_index :premade_monsters, :index, unique: true
  end
end
