class UsersController < ApplicationController
  def index
    @user = User.find(current_user.id)
    authorize! :index, @user

    @posts = Post
      .by_user(@user)
      .ordered_by_created_at_desc
      .paginate(:page => params[:page], :per_page => 10)
  end
end