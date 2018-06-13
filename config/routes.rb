Rails.application.routes.draw do
  resources :flats do
    resources :trips
  end

  resources :trips

  devise_for :users
  root to: 'flats#index'
end
