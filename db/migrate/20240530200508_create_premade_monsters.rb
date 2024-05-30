class CreatePremadeMonsters < ActiveRecord::Migration[7.1]
  def change
    create_table :premade_monsters do |t|
      t.string :name
      t.integer :health
      t.integer :armor_class
      t.integer :strength
      t.integer :dexterity
      t.integer :constitution
      t.integer :intelligence
      t.integer :wisdom
      t.integer :charisma
      t.string :size
      t.string :monster_type
      t.string :alignment
      t.integer :walking_speed
      t.integer :fly_speed
      t.integer :swim_speed
      t.timestamps
    end
  end
end
