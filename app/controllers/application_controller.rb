class ApplicationController < ActionController::API
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  private
  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout!(user)
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def logged_in?
    !current_user.nil?
  end

  def require_logged_in
    debugger

    render json: {base: ['invalid credentials']}, status: 401 if !current_user
  end
end
