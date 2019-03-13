class AddEnvironmentColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :score_gen, :integer, limit: 2
  end
end
