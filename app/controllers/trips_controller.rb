class TripsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
     @trips = policy_scope(trip).order(created_at: :desc)
  end

  def show
    @trip = Trip.find(params[:id])
    authorize @trip
  end

  def new
    @trip = trip.new
    authorize @trip
  end

  def create
    @trip = Trip.create(trip_params)
    @trip.user = current_user
    authorize @trip
    @trip.save!
    redirect_to trips_path
  end

  def edit
    @trip = Trip.find(params[:id])
    authorize @trip
  end

  def update
    @trip = Trip.find(params[:id])
    authorize @trip
    @trip.update_attributes(trip_params)
    redirect_to trips_path
  end

  def destroy
    @trip = Trip.find(params[:id])
    authorize @trip
    @trip.destroy
    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:name)
  end
end
