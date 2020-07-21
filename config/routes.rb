Rails.application.routes.draw do
  root 'chat_rooms#index'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: "users/registrations" }
  
  resources :chat_rooms do
  	resources :messages
  end
  resources :roles
  get '/profile/:id', to: 'persons#profile', as: 'profile'
  get '/profile/:user_id/role/:id', to: 'roles#edit', as: 'edit_user_role'
  get '/profile/:id/ban', to: 'persons#ban', as: 'ban_user'
  get '/profile/:id/unban', to: 'persons#unban', as: 'unban_user'
  get '/chat_rooms/:chat_room_id/user', to: 'favorites#add_to_favorite', as: 'favorite'
  get '/moon', to: 'application#moon', as: 'moon'
  get '/sun', to: 'application#sun', as: 'sun'
  get '/users/all', to: 'persons#users_profiles', as: 'users_profiles'
  get '/user_mute/user/:user_id/chat_room/:chat_room_id/new', to: 'user_mutes#new', as: 'new_user_mute'
  post '/user_mute/users/:user_id/chat_rooms/:chat_room_id', to: 'user_mutes#create', as: 'user_mutes'
  delete '/favorite/:id', to: 'favorites#delete_from_favorite', as: 'unfavorite'
  post '/profile/:user_id/roles', to: 'roles#create', as: 'user_role'
  patch '/profile/:user_id/roles/:id', to: 'roles#update', as: 'user_roles'
  mount ActionCable.server => '/cable'
end
