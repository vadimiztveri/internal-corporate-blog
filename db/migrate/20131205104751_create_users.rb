class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  "login"
      t.string  "email"
      t.string  "crypted_password"
      t.string  "password_salt"
      t.string  "avatar"
      t.string  "persistence_token"
      t.boolean "active"
      t.decimal "posts_count"
    end
  end
end