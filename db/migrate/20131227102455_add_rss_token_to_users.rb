class AddRssTokenToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :rss_token, :string
  end
end