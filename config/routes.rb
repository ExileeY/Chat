Rails.application.routes.draw do
  devise_for :users
  root 'chat_rooms#index'
end
