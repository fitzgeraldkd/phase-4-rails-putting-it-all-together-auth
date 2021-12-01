class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :authorize

  private

  def authorize
    @current_user = User.find_by(id: session[:user_id])
    render json: { errors: ["You are not logged in."] }, status: :unauthorized unless @current_user
  end

end
