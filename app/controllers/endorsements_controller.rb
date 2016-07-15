class EndorsementsController < ApplicationController

  def new
    @review = Review.find(params[:review_id])
    @endorsement = Endorsement.new
    create
  end

  def create
    @endorsement = Endorsement.new
    @endorsement.user = current_user
    @endorsement.review = Review.find(params[:review_id])
    if @endorsement.save
      redirect_to restaurants_path
    else
      flash[:notice] = 'Cannot endorse the same review twice'
      redirect_to restaurants_path
    end
  end
end
