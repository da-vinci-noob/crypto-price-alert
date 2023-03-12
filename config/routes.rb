Rails.application.routes.draw do
  post 'alerts/create', controller: 'price_alerts', action: 'create'
  post 'alerts/delete', controller: 'price_alerts', action: 'delete'
  get 'alerts/all_alerts', controller: 'price_alerts', action: 'all_alerts'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
