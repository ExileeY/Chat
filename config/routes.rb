Rails.application.routes.draw do
  devise_for :users
  root 'chat_rooms#index'
  resources :chat_rooms
  get '/profile/:id', to: 'persons#profile', as: 'profile'
end
