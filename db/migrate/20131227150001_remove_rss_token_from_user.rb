class RemoveRssTokenFromUser < ActiveRecord::Migration
  def change
  	remove_column :users, :rss_token
  end
end
