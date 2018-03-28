Rails.application.routes.draw do

  root                'rests#search'
  get     'search' =>  'rests#search'
  
  resources :rests
  
end