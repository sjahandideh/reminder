Reminder::Application.routes.draw do
  resources :staffs

  scope "/:name" do
    resources :appointments
    root :to => 'appointments#index'
  end

  root :to => 'staffs#index'
end
