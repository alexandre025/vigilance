Rails.application.routes.draw do

  root 'organizations#index'

  devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'register'
  }

  post '/search', to: 'home#search'

  get '/saved_contents', to: 'home#saved'

  resources :organizations do

    post '/invit', to: 'organizations#send_invit'
    get '/join', to: 'organizations#join'

    delete '/assignment/:assignment_id', to: 'organizations#delete_assignment', as: :delete_assignment

    resources :tags
    resources :contents do
      post '/to_read', to: 'contents#to_read'
      post '/like', to: 'contents#like'
    end
  end

end
