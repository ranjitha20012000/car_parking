Rails.application.routes.draw do
  get '/dashboard/home'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'dashboard#home'
  #root "home#index"
  #get 'vehicles/', to: 'vehicles#index'
  #get 'vehicles/new'
  resources :vehicles 
   
  get 'release_action/:id' ,to: 'vehicles#release_action'
      
    
  
end
