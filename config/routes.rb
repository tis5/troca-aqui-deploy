Rails.application.routes.draw do

  root to: "index#index"

  # controles de sessao
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"
  # root to: 'index'
  resources :items
  resources :pessoas
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
