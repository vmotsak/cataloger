Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  devise_scope :user do
    get "users/sign_up/admin", to: "registrations#admin"
    get "users/sign_up/owner", to: "registrations#owner"
  end

  resources :products do
    post 'mark_as_pro', on: :member
    post 'buy', on: :member
  end

  root 'products#index'
end
