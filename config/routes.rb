Rails.application.routes.draw do
  resources :rooms
  root 'home#index'
end
