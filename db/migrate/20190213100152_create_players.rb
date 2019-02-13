class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :pseudo
      t.string :email
      t.integer :score_geo
      t.integer :score_gci

      t.timestamps
    end
    add_index :players, :pseudo
  end
end
