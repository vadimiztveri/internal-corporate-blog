require 'spec_helper'

describe User do

  it { should validate_presence_of(:login) }
  it { should validate_presence_of(:password) }
  it { should have_many(:posts).class_name('Post') }
  it { should have_many(:new_posts).dependent(:delete_all).class_name('NewPost') }

  let(:user) { create :user }
  let(:post) { create :post }

  describe '#allowed' do
    let(:who) { nil }
    let(:what) { nil }
    subject { user.allowed(who, what) }

    context 'non self' do
      context 'non User instance as object' do
        context 'not persisted' do
          let(:who) { FactoryGirl.build :post }

          it { should == [] }
        end

        context 'persisted' do
          let(:who) { FactoryGirl.create :post }

          it { should == [] }
        end
      end

      context 'User instance as object' do
        context 'not persisted' do
          let(:who) { FactoryGirl.build :user }

          it { should == [] }
        end

        context 'persisted' do
          let(:who) { FactoryGirl.create :user }

          it { should == [] }
        end
      end
    end

    context 'self' do
      let(:what) { user }

      context 'non User instance as object' do
        context 'not persisted' do
          let(:who) { FactoryGirl.build :post }

          it { should == [] }
        end

        context 'persisted' do
          let(:who) { FactoryGirl.create :post }

          it { should == [] }
        end
      end

      context 'User instance as object' do
        context 'not persisted' do
          let(:who) { FactoryGirl.build :user }

          it { should == [] }
        end

        context 'persisted' do
          let(:who) { FactoryGirl.create :user }

          it { should == [:index] }
        end
      end
    end
  end

  describe 'after_create' do
    describe '#unread_posts' do
      before do
        3.times { FactoryGirl.create :post }
      end

      let(:all_posts) { Post.ordered_by_created_at_desc }
      subject { user.unread_posts.ordered_by_created_at_desc }

      it { should match_array(all_posts) }
    end
  end

  describe '#gravatar_url' do
    subject { user.gravatar_url }

    it { should_not be_nil }
  end
end
