# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get 'welcome/index'

  get 'about/index'

  match '/about', to: 'about#index', via: 'get'
  match '/welcome', to: 'welcome#index', via: 'get'
end
