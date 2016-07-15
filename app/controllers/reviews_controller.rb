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

  def destroy
    @review = Review.find(params[:id])
    if current_user.id == @review.user_id
      @review.destroy
      flash[:notice] = 'Review delted'
      redirect_to restaurants_path
    else
      flash[:notice] = "Cannot delete another user's review"
      redirect_to restaurants_path
    end
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
