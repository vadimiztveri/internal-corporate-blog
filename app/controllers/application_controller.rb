class ApplicationController < ActionController::Base
  include ::Auth

  protect_from_forgery with: :exception
  helper :all
  helper_method :current_user_session, :current_user
  before_filter :require_user

  rescue_from Auth::AccessDenied, :with => :redirect_unauthorized_user


  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "Необходим логин и пароль"
      redirect_to new_user_sessions_path
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "У вас нет прав смотреть эту страницу"
      redirect_to posts_url
      return false
    end
  end

  def redirect_unauthorized_user
    if current_user
      flash[:notice] = "У вас нет прав смотреть эту страницу"
      redirect_to posts_url
    else
      store_location
      flash[:notice] = "Необходим логин и пароль"
      redirect_back_or_default new_user_sessions_path
    end
  end

  def store_location
    session[:return_to] = request.url if request.get? && !request.xhr?
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
