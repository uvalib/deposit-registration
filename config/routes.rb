Rails.application.routes.draw do
  resources :registrations, only: [ :new, :create ]
  resources :deposit_status, only: [ :index ]

  resources :department_options, only: [:index, :create] do
    collection do
      patch '/', action: 'update'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :healthcheck, only: [ :index ]
  resources :version, only: [ :index ]

  # You can have the root of your site routed with "root"
  root to: redirect( path: '/registrations' )

  # explicit routes
  get '/registrations' => 'registrations#new'
  get '/deposit_status' => 'registrations#index'

end
