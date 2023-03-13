require 'sidekiq/web'

Rails.application.routes.draw do
  post 'alerts/create', controller: 'price_alerts', action: 'create'
  post 'alerts/delete', controller: 'price_alerts', action: 'delete'
  get 'alerts/all_alerts', controller: 'price_alerts', action: 'all_alerts'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(username, ENV['SIDEKIQ_USERNAME']) &&
      ActiveSupport::SecurityUtils.secure_compare(password, ENV['SIDEKIQ_PASSWORD'])
  end
  
  mount(Sidekiq::Web => "/sidekiqadmin")
  root 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
