Rails.application.routes.draw do

  resources :signups, only: :create

  post :token, to: 'sessions#create'

end
