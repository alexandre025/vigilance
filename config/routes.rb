Rails.application.routes.draw do

  root 'home#index'

  devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'register'
  }

  post '/search', to: 'home#search'

  resources :organizations do
    get '/invit', to: 'organizations#invit'
    post '/invit', to: 'organizations#send_invit'
    get '/join', to: 'organizations#join'
    resources :tags
    resources :contents
  end

end
