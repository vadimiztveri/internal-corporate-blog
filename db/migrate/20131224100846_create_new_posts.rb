class CreateNewPosts < ActiveRecord::Migration
  def change
    create_table :new_posts do |t|
      t.integer	:post_id, :null => false
      t.integer	:user_id, :null => false
    end

    add_index :new_posts, [:user_id, :post_id], :unique => true
  end
end