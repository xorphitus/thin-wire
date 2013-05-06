ThinWire::Application.routes.draw do
  devise_for :users
  resources :projects, except: %w(show) do
    resources :pages, except: %w(show)
  end

  root to: 'projects#index'
end
