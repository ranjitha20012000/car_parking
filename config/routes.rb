Rails.application.routes.draw do
  get '/dashboard/home'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'dashboard#home'
  root "home#index"

end