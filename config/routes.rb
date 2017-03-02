Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "businesses#index", as: :home
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "register", to: "users#new"
  resources :users, only: [:new, :create, :show]

  get "add_business", to: "businesses#new"
  resources :businesses, except: [:new, :destroy]
  resources :reviews, only: [:index, :create]
  resources :categories, only: [:index, :show]
end
