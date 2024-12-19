Rails.application.routes.draw do
  # resources :withdrawals
  # resources :deposits
  resources :transactions
  devise_for :accounts
  root "home#index"


  # Routes deposits
  # Get all deposits
  get "deposits", to: "deposits#index"
  # New deposit
  get "deposit/new", to: "deposits#new", as: "new_deposit"
  # Post deposit
  post "deposits", to: "deposits#create"

  # Routes withdrawals
  # Get all withdrawals
  get "withdrawals", to: "withdrawals#index"
  # New deposit
  get "withdrawal/new", to: "withdrawals#new", as: "new_withdrawal"
  # Post withdrawal
  post "withdrawals", to: "withdrawals#create"
end
