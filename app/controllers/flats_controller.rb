class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    if params[:query].nil? || params[:query].count("a-z") == 0
      @flats = policy_scope(Flat).order(created_at: :desc)
    else
      @flats_all = policy_scope(Flat).order(created_at: :desc)
      @flats = PgSearch.multisearch(params[:query])
    end
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
