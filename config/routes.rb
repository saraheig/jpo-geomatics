Rails.application.routes.draw do

  root to: redirect('/players')

  resources :players
  resource :session, only: %i[new create destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
