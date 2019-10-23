Rails.application.routes.draw do

  #Index
  root to: "index#index"

  # Documentação API
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'


  # controles de sessao
  resources :sessions, only: [:create]

  #Controle de cadastro
  resources :registrations, only: [:create]

  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"

  # items
  resources :items
  resources :pessoas
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
