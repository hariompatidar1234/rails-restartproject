class RatingsController < ApplicationController
  before_action :find_rating, only: %i[show update destroy]
  protect_from_forgery

  # Show all ratings
  def index
    ratings = Rating.all
    render json: ratings
  end

  # Create a rating
  def create
    rating = current_member.ratings(set_params)
    if rating.save
      render json: rating, status: :ok
    else
      render json: { errors: rating.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Show a particular rating
  def show
    render json: @rating
  end

  private

  def set_params
    params.permit(:rate, :comment, :book_id)
  end

  def find_rating
    @rating = Rating.find_by_id(params[:id])
    return if @rating

    render json: 'Rating not found'
  end
end
