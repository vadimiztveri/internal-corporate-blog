class Post < ActiveRecord::Base
  self.table_name = "posts"
  validates :title, :presence => true
  validates :text, :presence => true

  belongs_to :user, :class_name => '::User', :inverse_of => :posts
  has_many :new_posts, :dependent => :delete_all, :class_name => '::NewPost', :inverse_of => :post
  has_many :new_readers, :class_name => '::User', :through => :new_posts, :source => :user

  def self.allowed(object, subject)
    rules = []
    
    if subject == self && object.instance_of?(User)
      rules << :index
      rules << :rss
    end
    
    rules
  end

  def allowed(object, subject)
    rules = []
    
    if subject == self && object.instance_of?(User) && object.persisted?
      rules << :index
      rules << :new
      if object == subject.user
        rules << :edit 
        rules << :destroy
      end
      rules << :rss
    end
    
    rules
  end

  scope :ordered_by_created_at_desc, -> { order("created_at DESC") }
  scope :published, -> { where( :published => true) }
  scope :by_user, -> (user) { where("user_id = ?", user.id) }

  def new_post?(viewer)
    self.new_posts.by_user(viewer).any?
  end

  def view!(viewer)
    self.new_posts.by_user(viewer).each do |new_post|
      new_post.destroy!
    end
  end

  after_create :create_new_posts
  before_save :clear_text


  private

  def create_new_posts
    sql = <<-SQL
      INSERT INTO new_posts
      (post_id, user_id)
      (
        SELECT
          '#{self.id}',
          id
        FROM users
      )
    SQL

    self.class.connection.execute(sql)
    true
  end

  def clear_text
    sanitizer = HTMLSanitizer.new
    self.text = sanitizer.sanitize(self.text)
  end
end