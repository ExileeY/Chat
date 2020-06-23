Rails.application.routes.draw do
  devise_for :users
  root 'chat_rooms#index'
  resources :chat_rooms do
  	resources :messages
  end
  resources :roles
  get '/profile/:id', to: 'persons#profile', as: 'profile'
  get '/profile/:user_id/role/:id', to: 'roles#edit', as: 'edit_user_role'
  post '/profile/:user_id/roles', to: 'roles#create', as: 'user_role'
  patch '/profile/:user_id/roles/:id', to: 'roles#update', as: 'user_roles'
  mount ActionCable.server => '/cable'
end
