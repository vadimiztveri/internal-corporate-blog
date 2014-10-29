require 'spec_helper'

describe UserSessionsController do
  before do
    activate_authlogic
    User.delete_all
    Post.delete_all
  end

  describe "user is not authorized" do
    describe "GET new" do
      subject { get :new }

      it "respond with 200" do
        subject
        expect(response.status).to eq(200)
      end

      it "render with tamplate new" do
        subject
        should render_template('new')
      end

      it "assigns @user_session is nil" do
        subject
        assigns(:user_session).should_not be_nil
      end
    end

    describe "GET create" do
      subject { get :create }

      it "respond with 200" do
        subject
        expect(response.status).to eq(200)
      end

      it "render with tamplate new" do
        subject
        should render_template('new')
      end

      it "assigns @user_session is nil" do
        subject
        assigns(:user_session).should_not be_nil
      end
    end

    describe "GET destroy" do
      subject { get :destroy }

      it "respond with 302" do
        subject
        expect(response.status).to eq(302)
      end

      it "redirect to new user session" do
        subject
        should redirect_to(new_user_sessions_path)
      end

      it "assigns @user_session is nil" do
        subject
        assigns(:user_session).should be_nil
      end
    end
  end

  describe "user is authorized" do
    let!(:user) { FactoryGirl.create :user }

    describe "GET new" do
      subject { get :new }

      it "respond with 302" do
        subject
        expect(response.status).to eq(302)
      end

      it "should raise error" do
        subject
        should raise_error
      end
    end

    describe "GET create" do
      subject { get :create }

      it "respond with 302" do
        subject
        expect(response.status).to eq(302)
      end

      it "should raise error" do
        subject
        should raise_error
      end
    end

    describe "GET destroy" do
      subject { get :destroy }

      it "respond with 302" do
        subject
        expect(response.status).to eq(302)
      end

      it "redirect to new user session" do
        subject
        should redirect_to(new_user_sessions_path)
      end

      it "assigns @user_session is nil" do
        subject
        assigns(:user_session).should be_nil
      end
    end
  end
end