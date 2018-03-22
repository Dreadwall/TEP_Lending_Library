Rails.application.routes.draw do
  get 'home/upload_users'

  devise_for :users
  # Set the root url
  root :to => 'home#home'

  get 'errors/not_found'
  get 'errors/internal_server_error'

  resources :users
  resources :components
  resources :items do
    member do
       get 'item_components'
    end
  end
  resources :item_categories
  resources :component_categories
  resources :reservations
  resources :kits
  resources :schools

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'returns' => 'reservations#returns', as: :returns
  get 'pickup' => 'reservations#pickup', as: :pickup
  get 'rental_calendar/:month' => 'reservations#rental_calendar', as: :rental_calendar
  get 'users/:id/rental_calendar' => 'users#rental_calendar', as: :personal_rentals
  # get 'rental_form' => 'reservation#rental_form', as: :rental_form
  # get 'items/:id/item_components',  as: :content

  get '/' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  get 'upload_users' => 'home#upload_users', as: :upload_users
  post 'create_users' => 'home#create_users', as: :create_users

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  get '*a', to: 'errors#routing'

end
