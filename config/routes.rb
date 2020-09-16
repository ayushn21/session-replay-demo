Rails.application.routes.draw do
  
  root 'static_pages#home'
  get '/home', to: 'users#show'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
end
