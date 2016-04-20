class AddCommunityIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :community_id, :integer
  end
end
