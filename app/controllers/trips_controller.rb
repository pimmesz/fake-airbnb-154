class TripsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
     @trips = policy_scope(Trip).order(created_at: :desc)
  end

  def show
    @trip = Trip.find(params[:id])
    authorize @trip
  end

  def new
    @flat = Flat.find(params[:flat_id])
    @trip = Trip.new
    authorize @trip
  end

  def create
    @trip = Trip.create(trip_params)
    @trip.flat_id = params[:flat_id]
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
    params.require(:trip).permit(:description, :flat_id)
  end

  def user_is_owner?
    current_user.id == Flat.find(params[:flat_id]).user_id
  end
end
