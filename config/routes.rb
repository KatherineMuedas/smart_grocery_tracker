Rails.application.routes.draw do
  
  devise_for :users
  post '/products/select_products', to: "products#select_products", as: :select_products
  put '/products/move_to_inventory', to: "products#move_to_inventory", as: :move_to_inventory
  post '/fridges/select_fridges', to: "fridges#select_fridges", as: :select_fridges
  put '/fridges/move_to_list', to: "fridges#move_to_list", as: :move_to_list
  resources :products
  resources :fridges 
  root to: 'products#index'
end
