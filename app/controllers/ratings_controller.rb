class RatingsController < CooperativeController
  before_action :authenticate_user!

  # GET /statuses/1/rate/5.js
  def rate
    @rateable = polymorphic_parent_class.find(params[:id]) || ( not_found and return )

    authorize! :rate, @rateable

    current_user.rate! @rateable, params[:rating]
    @rateable.reload

    respond_to do |format|
      format.js { render :action => 'rate'}
    end
  end

  # GET /statuses/1/unrate
  def unrate
    @rateable = polymorphic_parent_class.find(params[:id]) || ( not_found and return )

    authorize! :rate, @rateable

    @rateable.person_ratings.find_all_by_person(current_user).destroy_all
    @rateable.reload

    respond_to do |format|
      format.js { render :action => 'rate'}
    end
  end
end
