class RecipesController < ApplicationController
  # before_action :authorize

  def index
    render json: Recipe.all
  end

  def create
    recipe = @current_user.recipes.create!(recipe_params)
    render json: recipe, status: :created
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  private

  # def authorize
  #   render json: { errors: ["You are not logged in."] }, status: :unauthorized unless session[:user_id]
  # end

  def recipe_params
    # user_id = session[:user_id]
    # params[:user_id] = session[:user_id]
    params.permit(:title, :instructions, :minutes_to_complete)
  end

end
