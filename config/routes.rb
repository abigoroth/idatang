Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "dashboard#index"
  resources :sessions
  get "/logout", to: 'sessions#destroy', as: :logout
  resources :collabs
  resources :nfts

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end

  get "/get_address", to: "application#get_address"
end
