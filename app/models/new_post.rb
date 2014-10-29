class NewPost < ActiveRecord::Base
	self.table_name = 'new_posts'

	belongs_to :user, :inverse_of => :new_posts
	belongs_to :post, :inverse_of => :new_posts

	scope :by_user, -> (viewer) { where("user_id = ?", viewer.id)}
end
