# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'clients#index'

  resources :clients, except: %i[show] do
    get :list, on: :collection, action: :filtered_list
  end

  resources :companies, only: %i[new create]
end
