Rails.application.routes.draw do

  get 'sessions/new'
  #sign-up
  get     '/signup' =>  'users#new'
  #serch
  root                  'rests#search'
  get     'search'  =>  'rests#search'
  # login
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :rests
  resources :users
  
end