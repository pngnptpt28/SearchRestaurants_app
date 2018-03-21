Rails.application.routes.draw do
  get 'stores_info/input'
  post 'stores_info/name'
  get 'stores_info/detail'
  root 'application#hello'
end