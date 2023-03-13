Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'pages#home'

  get 'about' => 'pages#about'

  resources :articles#, only: [:show, :index, :new, :create, :edit, :update]

  get 'signup', to: 'users#new'

  # post 'users' => 'users#create'
  resources :users, except: [:new]

  #  Login and logout routes
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :categories, except: [:destroy]
end
