class ApplicationController < ActionController::Base

  helper_method :current_user
  def current_user
    @c_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  helper_method :logged_in?
  def logged_in?
    puts "#{__method__}::#{current_user}/#{!!current_user}"
    return !!current_user
  end

  def require_user
    unless logged_in?
      flash[:alert] = "You need to be logged in to perform this action!!"
      redirect_to login_path
    end
  end

end
