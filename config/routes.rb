Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations] 
    as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects, except: [:show, :delete] do 
    member do
      get :get_developers
      post :add_developers
      get :view_piechart
      get :piechart_data
    end
  end
  resources :todos, except: [:new, :show, :delete] do
    member do
      post :update_status
    end
  end
  resources :users, except: [:show, :delete] 
  get 'projects_todos_status', to: 'dashboard#projects_todos_status'
  root 'dashboard#index'
end
