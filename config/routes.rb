Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :users, param: :_username
    end
  end

  namespace 'auth' do
    post '/login', to: 'authentication#login'
    get '/rsa-key', to: 'authentication#rsa_key'
  end

  # qualquer outra rota
  get '/*a', to: 'application#not_found'
end