Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'connect_four#index'
  post '/move', to: 'connect_four#move'
end
