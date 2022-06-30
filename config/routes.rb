Rails.application.routes.draw do
  root 'home#index'
  resources :rooms, except: [:show]
  get 'rooms/:room_identifier', to: 'rooms#show', as: 'room_show'
  post 'rooms/:room_identifier/estimate/:value', to: 'rooms#estimate', as: 'estimate'
  post 'rooms/:room_identifier/reset', to: 'rooms#reset_room', as: 'reset_room'
  post 'rooms/:room_identifier/reveal', to: 'rooms#reveal', as: 'reveal'

  get 'rooms/:room_identifier/create_participant', to: 'rooms#create_participant', as: 'create_participant'
  post 'rooms/enter', to: 'rooms#enter_room'

  mount ActionCable.server, at: '/cable'
end
