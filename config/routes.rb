Rails.application.routes.draw do

  root 'home#index'

  devise_for :users

  resources :organizations do
    resources :tags
  end

end
