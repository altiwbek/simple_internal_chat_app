# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :users do
    member do
      post :enable_multi_factor_authentication, to: 'users/multi_factor_authentication#verify_enable'
      post :disable_multi_factor_authentication, to: 'users/multi_factor_authentication#verify_disabled'
    end
  end
  resources :chats
  resources :messages
  get '/search_users' => 'users#search', as: :search_users
end
