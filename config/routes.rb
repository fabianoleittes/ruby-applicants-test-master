Rails.application.routes.draw do
  root to: "home#index"
  resources :models, only: %i[index]
end
