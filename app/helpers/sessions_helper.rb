module SessionsHelper

  # logs in the given user
  def log_in(user_id)
    session[:user_id] = user_id
  end

  # Return the current loggen-in user (if any)
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
end
