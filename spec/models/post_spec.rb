require 'spec_helper'

describe Post do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:text) }
  it { should belong_to(:user).class_name('User') }
  it { should have_many(:new_posts).dependent(:delete_all).class_name('NewPost') }

  describe '.allowed' do
    let(:who) { nil }
    let(:what) { nil }
    subject { described_class.allowed(who, what) }

    context 'non self' do
      context 'non User instance as object' do

        it { should == [] }
      end

      context 'User instance as object' do
        let(:who) { FactoryGirl.create :user }

        it { should == [] }
      end
    end

    context 'self' do
      let(:what) { described_class }
        context 'non User instance as object' do

        it { should == [] }
      end

      context 'User instance as object' do
        let(:who) { FactoryGirl.create :user }

        it { should == [:index, :rss] }
      end
    end
  end

  let(:user) { FactoryGirl.create :user }
  let(:post) { FactoryGirl.create :post }

  describe '#allowed' do
    let(:who) { nil }
    let(:what) { nil }
    subject { post.allowed(who, what) }

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

      context 'Post instance as object' do
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
      let(:what) { post }

      context 'non Post instance as object' do
        context 'not persisted' do
          let(:who) { FactoryGirl.build :post }

          it { should == [] }
        end
        context 'persisted' do
          let(:who) { FactoryGirl.create :post, :user => user }

          it { should == [] }
        end
      end

      context 'Post instance as object' do
        context 'not persisted' do
          let(:who) { FactoryGirl.build :user }

          it { should == [] }
        end
        
        context 'persisted' do
          describe 'current_user is not author' do            
            let(:who) { FactoryGirl.create :user }

            it { should == [:index, :new, :rss] }
          end

          describe 'current_user is author' do            
            let(:user) { FactoryGirl.create :user }
            let(:post) { FactoryGirl.create :post, :user => user }

            subject { post.allowed(user, post) }

            it { should == [:index, :new, :edit, :destroy, :rss] }
          end
        end
      end
    end
  end

  describe '.ordered_by_created_at_desc' do
    before { described_class.delete_all }

    let!(:post1) { FactoryGirl.create :post, :created_at => Time.now }
    let!(:post2) { FactoryGirl.create :post, :created_at => (Time.now + 1.second) }

    subject { described_class.ordered_by_created_at_desc }

    it { should match_array([post2, post1]) }
  end

  describe '.published' do
    before { described_class.delete_all }

    let!(:post1) { FactoryGirl.create :post, :published => true, :created_at => Time.now }
    let!(:post2) { FactoryGirl.create :post, :published => false, :created_at => (Time.now + 1.second) }
    let!(:post3) { FactoryGirl.create :post, :published => true, :created_at => (Time.now + 3.second) }

    subject { described_class.published }

    it { should match_array([post3, post1]) }
  end

  describe '.by_user' do
    before { described_class.delete_all }

    let!(:user1) { FactoryGirl.create :user }

    let!(:post1) { FactoryGirl.create :post, :user => user, :created_at => Time.now }
    let!(:post2) { FactoryGirl.create :post, :user => user1, :created_at => (Time.now + 1.second) }
    let!(:post3) { FactoryGirl.create :post, :user => user, :created_at => (Time.now + 3.second) }

    subject { described_class.by_user(user) }

    it { should match_array([post3, post1]) }
  end

  describe '#new_post?' do
    let(:post) { FactoryGirl.create :post }
    let(:user) { FactoryGirl.create :user }

    subject { post.new_post?(user) }

    context 'new' do
      it { should be_true }
    end

    context 'not new' do
      before { post.view!(user) }

      it { should be_false }
    end
  end

  describe '#view!' do
    let(:post) { FactoryGirl.create :post }
    let(:user) { FactoryGirl.create :user }

    def new_post?
      post.new_post?(user)
    end

    subject { post.view!(user) }

    it do
      expect{subject}.to change{ new_post? }.from(true).to(false)
    end
  end

  describe 'after_create' do
    describe '.new_readers' do
      before do
        described_class.delete_all
        User.delete_all
        2.times { FactoryGirl.create :user }
      end

      let(:all_users) { User.all.to_a }
      let(:post) { FactoryGirl.create :post }

      subject { post.new_readers.to_a }

      it { should == all_users }
    end
  end

  describe 'after_create' do
    describe '.clear_text' do
      let(:sanitizer) { HTMLSanitizer.new }

      subject { sanitizer }
      it { should be_kind_of(HTMLSanitizer) }
    end
  end

  describe '#gravatar_url' do
    subject { user.gravatar_url }
    
    it { should_not be_nil }
  end  
end
