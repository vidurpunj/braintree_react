Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :events
  root to: 'events#index'

  post '/chekout', to: 'events#client_token', as: 'client_token'

end
