Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/activities', to: 'trips#find_places'
      post '/restaurants', to: 'trips#find_restaurants'
      post '/signup', to: 'users#create'
      post '/login', to: 'auth#create'
      get '/user', to: 'users#user_data'
    end
  end
end
