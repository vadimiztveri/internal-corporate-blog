require 'spec_helper'

describe UsersController do
  before do
    activate_authlogic
    User.delete_all
    Post.delete_all
  end

  describe "GET index" do

    describe "user is not authorized" do
      subject { get :index }

      it "respond with 302" do
        subject
        expect(response.status).to eq(302)
      end

      it "redirect to new user session" do
        subject
        should redirect_to(new_user_sessions_path)
      end

      it "assigns @user is nil" do
        subject
        assigns(:user).should be_nil
      end

      it "assigns @posts is nil" do
        subject
        assigns(:posts).should be_nil
      end
    end

    describe "user is authorized" do
      let!(:user) { FactoryGirl.create :user }
      let!(:posts) do
        2.times { FactoryGirl.create :post, :user => user }
        posts = Post.where(:user => user)
      end

      subject { get :index }

      it "respond with 200" do
        subject
        expect(response.status).to eq(200)
      end

      it "assigns @user" do
        subject
        assigns(:user).should eq(user)
      end

      it "assigns @posts" do
        subject
        assigns(:posts).should match_array(posts)
      end

      it "render with tamplate index" do
        subject
        should render_template('index')
      end
    end
  end
end
