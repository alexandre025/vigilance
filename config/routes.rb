Rails.application.routes.draw do

  root 'home#index'

  devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'register'
  }

  post '/search', to: 'home#search'

  resources :organizations do

    post '/invit', to: 'organizations#send_invit'
    get '/join', to: 'organizations#join'

    delete '/assignment/:assignment_id', to: 'organizations#delete_assignment', as: :delete_assignment

    resources :tags
    resources :contents do
      post '/follow', to: 'contents#follow'
      post '/unfollow', to: 'contents#unfollow'
    end
  end

end
