Rails.application.routes.draw do
  get 'trips/index'
  get 'trips/show'
  get 'trips/new'
  get 'trips/create'
  get 'trips/edit'
  get 'trips/update'
  get 'trips/destroy'
  resources :flats do
    resources :trips
  end

  devise_for :users
  root to: 'flats#index'
end
