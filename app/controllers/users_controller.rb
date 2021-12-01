class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
  skip_before_action :authorize, only: :create

  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    render json: user, status: :created
  end

  def show
    # user = User.find(session[:user_id])
    render json: @current_user
  # rescue ActiveRecord::RecordNotFound
    # render json: "User not found", status: :unauthorized
  end

  private

  def render_invalid(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def user_params
    params.permit(:username, :password, :password_confirmation, :image_url, :bio)
  end

end
