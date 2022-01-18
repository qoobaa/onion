# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#show'
  get '/auth/:provider/callback', to: 'sessions#create'

  resource :session, only: [:destroy]
  resources :orders, only: [:index, :new, :create]
  resources :imports, only: [:new, :create]
end
