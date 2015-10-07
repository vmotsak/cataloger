Rails.application.routes.draw do
  devise_for :users
  devise_for :admins, controllers: { registrations: "admins_registrations" }
  devise_for :owners, controllers: { registrations: "owners_registrations" }

  resources :products do
    post 'mark_as_pro', on: :member
    post 'buy', on: :member
  end

  root 'products#index'
end
