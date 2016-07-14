class ReviewsController < ApplicationController

  before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    # @restaurant = Restaurant.find(params[:restaurant_id])
    # @restaurant.reviews.create(review_params)
    # @restaurant.user_id = current_user
    @review = Review.new(review_params)
    @review.user = current_user
    @review.restaurant = Restaurant.find(params[:restaurant_id])
    @review.save
    redirect_to '/restaurants'
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
