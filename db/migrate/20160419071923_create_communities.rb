class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :name, :default => "", :null => false
      t.string :about, :default => "", :null => false
      t.integer :user_id
      t.string :avatar
      t.string :cover
      t.string :slug
      t.integer :posts_count, :default => 0, :null => false

      t.timestamps
    end
  end
end
