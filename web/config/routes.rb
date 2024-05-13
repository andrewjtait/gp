# frozen_string_literal: true

Rails.application.routes.draw do
  root 'searches#show'

  resource :search, except: :destroy do
    get :stop
  end

  post 'api/search', to: 'api#search'
end
