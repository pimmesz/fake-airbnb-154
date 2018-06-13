class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
     @flats = policy_scope(Flat).order(created_at: :desc)
  end

  def show
    @flat = Flat.find(params[:id])
    authorize @flat
  end

  def new
    @flat = Flat.new
    authorize @flat
  end

  def create
    @flat = Flat.create(flat_params)
    @flat.user = current_user
    authorize @flat
    @flat.save!
    redirect_to flats_path
  end

  def edit
    @flat = Flat.find(params[:id])
    authorize @flat
  end

  def update
    @flat = Flat.find(params[:id])
    authorize @flat
    @flat.update_attributes(flat_params)
    redirect_to flats_path
  end

  def destroy
    @flat = Flat.find(params[:id])
    authorize @flat
    @flat.destroy
    redirect_to flats_path
  end

  private

  def flat_params
    params.require(:flat).permit(:name, :city)
  end
end
