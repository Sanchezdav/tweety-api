Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: 'auth'

    namespace :v1 do
      resources :posts do
        resources :comments, except: :show do
          post '/like', to: 'comments#like'
          post '/dislike', to: 'comments#dislike'
        end
      end
    end
  end
end
