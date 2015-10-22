Rails.application.routes.draw do
  
  devise_for :users
  resources :products
  resources :fridges 
  root to: 'products#index'
end
