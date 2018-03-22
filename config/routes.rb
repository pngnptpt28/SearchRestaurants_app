Rails.application.routes.draw do
  get 'rests/show'

  root                'stores_info#input'
  get   '/input'  =>  'store_info#input'
  post  '/name'   =>  'stores_info#name'
  get   '/detail' =>  'stores_info#detail'
  
  resources :rests
end