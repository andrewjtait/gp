# frozen_string_literal: true

Rails.application.routes.draw do
  root 'searches#index'

  resources :searches, path: :search, except: :show

  post 'api/search', to: 'api#search'
end
