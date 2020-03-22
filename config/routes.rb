Rails.application.routes.draw do
  devise_for :users
  root 'chat_rooms#index'
  resources :chat_rooms do
  	resources :messages
  end
  get '/profile/:id', to: 'persons#profile', as: 'profile'
end
