Rails.application.routes.draw do
  root to: 'site#index'
  devise_for :users
  
  get 'site/purchase'
  get 'site/buy_product', 'site#buy_product'
  get 'site/transfer'
  post 'site/transfer_money', 'site#transfer_money'
  # get 'site/download_product'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
