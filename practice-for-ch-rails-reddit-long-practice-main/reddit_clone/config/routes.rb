Rails.application.routes.draw do
  resources :subs do 
     resources :posts, only:[:show,:create,:edit,:update,:new]
  end
  resources :users
  resource :session, only:[:new, :create, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
