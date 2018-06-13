Rails.application.routes.draw do
  resources :flats
  devise_for :users
  root to: 'flats#index'
end
