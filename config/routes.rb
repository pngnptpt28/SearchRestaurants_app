Rails.application.routes.draw do

  get     '/signup' =>  'users#new'

  root                  'rests#search'
  get     'search'  =>  'rests#search'
  
  resources :rests
  resources :users
  
end