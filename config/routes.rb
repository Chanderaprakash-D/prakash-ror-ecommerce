Rails.application.routes.draw do
  resources :cart_items
  resources :orders
  resources :customers
  resources :products
  resources :categories

  root "dashboard#index"
end