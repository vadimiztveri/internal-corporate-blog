require 'spec_helper'

describe NewPost do
  it { should belong_to(:user).class_name('User') }
  it { should belong_to(:post).class_name('Post') }

  describe '.by_user' do
    let(:user) { FactoryGirl.create :user }

    before do
      5.times { FactoryGirl.create :new_post, :user => user }
    end

    let(:all_new_posts) { NewPost.all }
    subject { all_new_posts.by_user(user) }

    it { should match_array(all_new_posts.where("user_id = ?", user.id)) }
  end
end
