class CreateCreatures < ActiveRecord::Migration[7.1]
  def change
    create_table :creatures do |t|
      t.string :name
      t.integer :health
      t.integer :armor_class
      t.integer :initiative
      t.references :encounter, foreign_key: true
      t.timestamps
    end
  end
end
