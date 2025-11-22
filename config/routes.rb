Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "auth/sign_up", to: "auth#sign_up"
      post "auth/login", to: "auth#login"
      resources :timesheets do
        resources :line_items, only: [ :create, :update, :destroy ]
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
