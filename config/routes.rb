Rails.application.routes.draw do
  get 'registrations/admin'
  get 'registrations/owner'
  get 'registrations/visitor'

  resources :products
  devise_for :users
  root 'products#index'
end
