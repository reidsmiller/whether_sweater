Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v0 do
      get '/forecast', to: 'forecast#show'
      resources :users, only: [:create]
      resources :sessions, only: [:create]
      get 'book-search', to: 'book_search#index'
    end
  end
end
