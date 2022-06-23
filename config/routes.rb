Rails.application.routes.draw do
  resources :rooms, except: [:show]
  get 'rooms/:room_identifier', to: 'rooms#show', as: 'room_show'
  post 'room/:room_identifier/estimate/:value', to: 'rooms#estimate', as: 'estimate'
  root 'home#index'

  get 'rooms/:room_identifier/create_participant', to: 'rooms#create_participant', as: 'create_participant'

  mount ActionCable.server, at: '/cable'
end
