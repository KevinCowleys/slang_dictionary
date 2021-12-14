Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  # Login routes
  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'
  get 'sign_in', to: 'sessions#new', as: :log_in
  post 'sign_in', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout

  # Password routes
  get 'password', to: 'passwords#edit', as: :edit_password
  patch 'password', to: 'passwords#update'
  # get 'password/reset', to: 'password_resets#new'
  # post 'password/reset', to: 'password_resets#create'
  # get 'password/reset/edit', to: 'password_resets#edit'
  # patch 'password/reset/edit', to: 'password_resets#update'

  # Slangs routes
  get 'slangs/new', to: 'slangs#new', as: :slang_new
  post 'slangs/new', to: 'slangs#create', as: :slang_create
  post 'slangs/like', to: 'slangs#like', as: :slang_like

  # Searches
  get 'search', to: 'search#show'

  # User routes
  get 'user/:username', to: 'user#show', username: %r{[^/]+}
  get 'profile/settings', to: 'user#settings', as: :settings
  patch 'profile/settings', to: 'user#settings_update', as: :settings_update

  # Admin routes
  get 'admin', to: 'admin#show', as: :admin
  patch 'admin/slang/:slang_id/approve/', to: 'admin#approve', as: :admin_slang_approve
  delete 'admin/slang/:slang_id/remove/', to: 'admin#destroy', as: :admin_slang_remove
end
