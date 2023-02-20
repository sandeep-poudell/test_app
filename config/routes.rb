Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles
  get 'signup', to: 'users#new'
  # post 'users', to: 'users#create'
  resources :users, except: [:new]      #`new` is handled by signup route

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

end

