class RatingsController < ApplicationController

  def update
    @rating = Rating.find(params[:id])
    @comment = @rating.comment
    if @rating.update_attributes(score: params[:score])
      rating.user_id = current_user
      rating.save
      respond_to do |format|
        format.js
      end
    end
  end

end