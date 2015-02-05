Rails.application.routes.draw do

  resources :signups, only: :create
  resources :sessions, only: :create

end
