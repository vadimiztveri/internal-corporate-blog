require 'spec_helper'

describe PostsController do
  before do
    activate_authlogic
    User.delete_all
    Post.delete_all
  end

  let!(:posts) do
    2.times { FactoryGirl.create :post }
    posts = Post.all
    posts
  end

  describe "user is not authorized" do
    describe "GET index" do
      subject { get :index }

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
        assigns(:posts).should be_nil
      end
    end

    describe "GET new" do
      subject { get :new }

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
        assigns(:posts).should be_nil
      end
    end

    describe "GET create" do
      subject { get :create }

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
        assigns(:posts).should be_nil
      end
    end

    describe "GET show" do
      subject { get :show, :id => posts.first }

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
        assigns(:posts).should be_nil
      end
    end

    describe "GET edit" do
      subject { get :edit, :id => posts.first }

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
        assigns(:posts).should be_nil
      end
    end

    describe "GET update" do
      subject { get :update, :id => posts.first }

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
        assigns(:posts).should be_nil
      end
    end

    describe "GET destroy" do
      subject { get :destroy, :id => posts.first }

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
        assigns(:posts).should be_nil
      end
    end
  end

  describe "user is authorized" do
    let!(:user) { FactoryGirl.create :user }

    describe "GET index" do
      subject { get :index }

      it "respond with 200" do
        subject
        expect(response.status).to eq(200)
      end

      it "assigns @user" do
        subject
        assigns(:posts).should eq(posts)
      end

      # it "assigns @user_session is nil" do
      #   subject
      #   assigns(:posts).should be_nil
      # end
    end

    # describe "GET new" do
    #   subject { get :new }

    #   it "respond with 302" do
    #     subject
    #     expect(response.status).to eq(302)
    #   end

    #   it "redirect to new user session" do
    #     subject
    #     should redirect_to(new_user_sessions_path)
    #   end

    #   it "assigns @user_session is nil" do
    #     subject
    #     assigns(:posts).should be_nil
    #   end
    # end

    # describe "GET create" do
    #   subject { get :create }

    #   it "respond with 302" do
    #     subject
    #     expect(response.status).to eq(302)
    #   end

    #   it "redirect to new user session" do
    #     subject
    #     should redirect_to(new_user_sessions_path)
    #   end

    #   it "assigns @user_session is nil" do
    #     subject
    #     assigns(:posts).should be_nil
    #   end
    # end

    # describe "GET show" do
    #   subject { get :show, :id => posts.first }

    #   it "respond with 302" do
    #     subject
    #     expect(response.status).to eq(302)
    #   end

    #   it "redirect to new user session" do
    #     subject
    #     should redirect_to(new_user_sessions_path)
    #   end

    #   it "assigns @user_session is nil" do
    #     subject
    #     assigns(:posts).should be_nil
    #   end
    # end

    # describe "GET edit" do
    #   subject { get :edit, :id => posts.first }

    #   it "respond with 302" do
    #     subject
    #     expect(response.status).to eq(302)
    #   end

    #   it "redirect to new user session" do
    #     subject
    #     should redirect_to(new_user_sessions_path)
    #   end

    #   it "assigns @user_session is nil" do
    #     subject
    #     assigns(:posts).should be_nil
    #   end
    # end

    # describe "GET update" do
    #   subject { get :update, :id => posts.first }

    #   it "respond with 302" do
    #     subject
    #     expect(response.status).to eq(302)
    #   end

    #   it "redirect to new user session" do
    #     subject
    #     should redirect_to(new_user_sessions_path)
    #   end

    #   it "assigns @user_session is nil" do
    #     subject
    #     assigns(:posts).should be_nil
    #   end
    # end

    # describe "GET destroy" do
    #   subject { get :destroy, :id => posts.first }

    #   it "respond with 302" do
    #     subject
    #     expect(response.status).to eq(302)
    #   end

    #   it "redirect to new user session" do
    #     subject
    #     should redirect_to(new_user_sessions_path)
    #   end

    #   it "assigns @user_session is nil" do
    #     subject
    #     assigns(:posts).should be_nil
    #   end
    # end
  end
end
