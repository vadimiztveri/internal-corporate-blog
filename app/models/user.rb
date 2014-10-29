class User < ActiveRecord::Base
  self.table_name = "users"

  validates :login, :presence => true
  validates :password, :presence => true
  validates :active, :presence => true

	has_many :posts, :class_name => '::Post', :inverse_of => :user

  has_many :new_posts, :dependent => :delete_all, :class_name => '::NewPost', :inverse_of => :user
  has_many :unread_posts, :class_name => '::Post', :through => :new_posts, :source => :post

  acts_as_authentic do |c|
    c.validate_email_field = false
    c.validate_password_field = false
  end

  def allowed(object, subject)
    rules = []

    if subject == self && object.instance_of?(User) && object.persisted?
      rules << :index
    end

    rules
  end

  after_create :create_new_posts

  include Gravtastic
  gravtastic :email


  private

	def create_new_posts
		sql = <<-SQL
			INSERT INTO new_posts
			(post_id, user_id)
			(
				SELECT
					id,
					'#{self.id}'
				FROM posts
			)
		SQL

		self.class.connection.execute(sql)
		true
	end
end
