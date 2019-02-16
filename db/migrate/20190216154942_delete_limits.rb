class DeleteLimits < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :password_digest, :text, :limit => nil
  end
end
