Rails.application.routes.draw do
  resources :registrations, only: [ :new, :create ]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :healthcheck, only: [ :index ]
  resources :version, only: [ :index ]

  # You can have the root of your site routed with "root"
  root 'registrations#new'
end
