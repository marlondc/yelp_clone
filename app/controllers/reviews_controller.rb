class ReviewsController < ApplicationController

  before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.restaurant = Restaurant.find(params[:restaurant_id])
    if @review.save
      redirect_to '/restaurants'
    else
      flash[:notice] = 'Cannot review same restaurant twice'
      redirect_to '/restaurants'
    end
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
