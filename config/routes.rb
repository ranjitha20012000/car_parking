Rails.application.routes.draw do
  get '/dashboard/home'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'vehicles#index'
  get 'admin' => "dashboard#home"
  #root "home#index"
  #get 'vehicles/', to: 'vehicles#index'
  #get 'vehicles/new'
  resources :vehicles 
   
  get 'release_action/:id' ,to: 'vehicles#release_action'
  resources :charges, only: [:index, :edit, :update, :create]
  get '/charges/:id/edit' , to: 'charges#edit'
  patch 'charges/:id', to: 'charges#update'
  get '/charges/:id', to: 'charges#index'
  get '/charges', to: 'charges#index'
  post '/charges', to: 'charges#create'
end


