class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :pseudo, limit: 25
      t.string :email, limit: 50
      t.integer :score_geo, limit: 2
      t.integer :score_gci, limit: 2

      t.timestamps
    end
    add_index :players, :pseudo, unique: true
  end
end
