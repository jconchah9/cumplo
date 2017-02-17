Rails.application.routes.draw do
  devise_for :accounts
  get 'home/search', to: 'home#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
