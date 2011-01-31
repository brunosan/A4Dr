class AddAppIdToRankings < ActiveRecord::Migration
  def self.up
    add_column :rankings, :app_id, :integer
  end

  def self.down
    remove_column :rankings, :app_id
  end
end
