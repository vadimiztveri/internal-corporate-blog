class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
	    t.string   "title"
	    t.text     "text"
	    t.datetime "created_at"
	    t.datetime "updated_at"
	    t.integer  "user_id"
	    t.boolean  "published"
    end
  end
end
