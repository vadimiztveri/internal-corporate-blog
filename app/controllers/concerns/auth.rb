module Auth
  extend ActiveSupport::Concern

  class AccessDenied < ArgumentError; end

  included do
    helper_method :current_user, :abilities, :can?, :authorize!

    after_filter :store_location, :if => lambda {|controller| controller.request.get? && controller.request.format == :html}
  end


  private

  def abilities
    @abilities ||= Six.new
  end

  def can?(action, subject)
    abilities << subject
    abilities.allowed?(current_user, action, subject)
  end

  def authorize!(action, subject = self)
    raise AccessDenied unless can?(action, subject)
  end

  def store_location
    session[:return_to] = request.protocol + request.host_with_port + request.path
    true
  end

  def redirect_back_or_default(default, options = {})
    return_to = session[:return_to].blank? ? default : session[:return_to]
    session[:return_to] = nil

    respond_to do |format|
      format.js { render :js => "window.location.href='#{return_to}';" }
      format.html { redirect_to return_to, options }
    end
  end

  def require_no_user
    if current_user
      flash[:error] = 'Вы должны быть разлогинены'
      redirect_back_or_default dealer_path(current_user.dealer)
    end
  end

  def require_user
    unless current_user
      flash[:error] = 'Вы должны выполнить вход'
      redirect_back_or_default new_user_sessions_path
    end
  end
end