Rails.application.routes.draw do

  root 'home#index'

  devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'register'
  }

  resources :organizations do
    resources :tags
    resources :contents
  end

end
