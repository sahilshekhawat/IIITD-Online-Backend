class AddCommunityIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :community_id, :integer
  end
end
