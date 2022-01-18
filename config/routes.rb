# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#show'
  get '/auth/:provider/callback', to: 'sessions#create'
end
