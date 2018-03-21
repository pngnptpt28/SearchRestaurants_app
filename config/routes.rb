Rails.application.routes.draw do
  root 'stores_info#input'
  get '/input', to: 'store_info#input'
  post '/name', to: 'stores_info#name'
  get '/detail', to: 'stores_info#detail'
  # root 'application#hello'
end