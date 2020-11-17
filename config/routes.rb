Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/dashboard', to: 'pages#dashboard'
  get '/mailer', to: 'pages#mailer'
  resources :instances do
    resources :beers, only: [:index, :new, :create, :show, :edit, :update]
  end
end
