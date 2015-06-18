Rails.application.routes.draw do

  root "static_pages#home"
  get "login"     => "sessions#new"
  post "login"    => "sessions#create"
  delete "logout" => "sessions#destroy"
  get "help"      =>  "static_pages#help"
  get "about"     =>  "static_pages#about"
  get "contact"   =>  "static_pages#contact"
  get "signup"    =>  "users#new"
  
  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :categories
  end
  resources :users do
    resources :following, only: [:index]
    resources :followed, only: [:index]
  end
  resources :relationships, only: [:create, :destroy]
  resources :users, except: :destroy
  resources :relationships, only: [:create, :destroy]
end
