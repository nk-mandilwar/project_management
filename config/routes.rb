Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations] 
    as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects, except: [:show, :delete] do 
    member do
      get :developers
      post :add_developer
    end
  end
  resources :todos, except: [:new, :show, :delete]
  resources :users, except: [:show, :delete] 
  root 'dashboard#index'
end
