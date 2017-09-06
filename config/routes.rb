Rails.application.routes.draw do
  devise_for :admin, controllers: { registrations: "admin/registrations",sessions: "admin/sessions" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "static_pages#index"

  resources :admin, except: [:create] do
    member do
      get :account
    end
  end

  post 'create_admin' => 'admin#create', as: :create_admin

end
