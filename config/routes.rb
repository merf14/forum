Rails.application.routes.draw do
  scope '/(:locale)', locale: /en|ru/ do
    root "themes#main"
    get 'users/registration', to: "users#registration"
    post 'users/registration', to: "users#registration"
    get 'users/authorization', to: "users#authorization"
    post 'users/authorization', to: "users#authorization"
    get '/users/delete', to: 'users#delete'
    post '/users/delete', to: 'users#delete'
    get '/users/change', to: 'users#change'
    post '/users/change', to: 'users#change'
    get '/users/profile/:id', to: 'users#profile' 
    post '/users/logout', to: 'users#logout'
    post '/users/set_en', to: 'users#set_en'
    post '/users/set_ru', to: 'users#set_ru'

    get '/themes/main', to: "themes#main"
    get '/themes/create', to: "themes#create"
    post '/themes/create', to: "themes#create"
    post '/themes/delete', to: "themes#delete"
    get '/themes/show/:id', to: 'themes#show'
    post '/themes/create_ans', to: "themes#create_ans"
    post '/themes/delete_ans', to: "themes#delete_ans"
  end
end
