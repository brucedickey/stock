# For details on the DSL available within this file, 
# see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  resources :user_stocks,  only: [:create, :destroy]
  resources :user_friends, only: [:create, :destroy]

  devise_for :users

  root 'welcome#index'

  get 'my_portfolio',  to: 'users#my_portfolio'
  get 'search_stock',  to: 'company_stocks#search'

  get 'my_friends',    to: 'users#my_friends'
  get 'search_friend', to: 'users#search'
end
