class ChangeGamesTable < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :name, :string
    add_reference :games, :user, foreign_key: true
  end
end
