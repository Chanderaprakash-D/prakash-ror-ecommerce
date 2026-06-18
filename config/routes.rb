Rails.application.routes.draw do
  get "/health", to: proc { [200, {}, ["OK"]] }
  resources :cart_items
  resources :orders
  resources :customers
  resources :products
  resources :categories

  root "dashboard#index"
end