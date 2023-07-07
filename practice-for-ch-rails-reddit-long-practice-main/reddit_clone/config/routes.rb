Rails.application.routes.draw do
  resources :subs
  resources :posts
  resources :users
  resource :session
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
