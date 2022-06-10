Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :users, param: :_username, only: [:show, :create, :update, :destroy] do
        resources :todos, only: [:create, :update, :destroy]
      end
    end
  end

  namespace 'auth' do
    post '/login', to: 'authentication#login'
    get '/rsa-key', to: 'authentication#rsa_key'
  end

  # qualquer outra rota
  match '/*a', to: 'application#not_found', via: [:get, :post, :put, :delete, :options, :patch]
end