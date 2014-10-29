Blog::Application.routes.draw do

  root :controller => "user_sessions", :action => "new"

  resources :users
  resources :posts
  resource :user_sessions

  resource :debugs
end
