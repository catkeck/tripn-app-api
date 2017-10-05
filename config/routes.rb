Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/activities', to: 'schedules#find_places'
      post '/restaurants', to: 'schedules#find_restaurants'
      post '/indoor_activities', to: 'schedules#find_indoor_places'
      post '/signup', to: 'users#create'
      post '/login', to: 'auth#create'
      get '/user', to: 'users#user_data'
      post '/user/save_image', to: 'users#save_image'
      post '/user/save_interests', to: 'users#save_interests'
      post '/schedules/new', to: 'schedules#create'
      post '/tinydancer/get_token', to: 'uber#get_token'
      post '/tinydancer/get_products', to: 'uber#get_products'
      post '/tinydancer/get_price_estimate', to: 'uber#get_price_estimate'
      post '/tinydancer/book_ride', to: 'uber#book_ride'
    end
  end
end
