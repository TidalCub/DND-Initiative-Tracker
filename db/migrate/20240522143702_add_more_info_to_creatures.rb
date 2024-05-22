class AddMoreInfoToCreatures < ActiveRecord::Migration[7.1]
  def change
    add_column :creatures, :strength, :integer
    add_column :creatures, :dexterity, :integer
    add_column :creatures, :constitution, :integer
    add_column :creatures, :intelligence, :integer
    add_column :creatures, :wisdom, :integer
    add_column :creatures, :charisma, :integer
    add_column :creatures, :size, :string
    add_column :creatures, :monster_type, :string
    add_column :creatures, :alignment, :string
    add_column :creatures, :walking_speed, :integer
    add_column :creatures, :fly_speed, :integer
    add_column :creatures, :swim_speed, :integer
  end
end
