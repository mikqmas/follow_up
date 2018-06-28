Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      scope :clover do
        get "/auth", to: "clovers#auth"
        get "/test", to: "clovers#test"
        get "/login", to: "clovers#login"
      end

      post "/webhook", to: "webhooks#notify"

      # User
      post "/users", to: "users#create"
    end
  end
end
