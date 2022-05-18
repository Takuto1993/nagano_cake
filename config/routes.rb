Rails.application.routes.draw do
  namespace :public do
    get 'cart_items/index'
  end
  namespace :public do
    resources :customers, only: [:show, :edit, :update]
    resources :address, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]
    get '/' => "homes#top"
    get 'homes/about'
  end
  namespace :admin do
    resources :genres, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :new, :show, :edit, :create, :update, :destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    get 'homes/top'
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
