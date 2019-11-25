Rails.application.routes.draw do

  resources :tokens, only: [:create, :update]

  # GET por id pessoa
  get "/tokenpessoa/:pessoa_id", to: "tokens#showpessoa"

  get "/itemspessoa/:pessoa_id", to: "items#showpessoa"


  #Index
  root to: "index#index"

  # Documentação API
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'


  # controles de sessao
  resources :sessions, only: [:create]

  #Controle de cadastro
  resources :registrations, only: [:create]


  # Logout
  delete :logout, to: "sessions#logout"
  # Login check
  get :logged_in, to: "sessions#logged_in"




  # items
  resources :items
  resources :pessoas
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
