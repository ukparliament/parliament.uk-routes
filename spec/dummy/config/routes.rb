Rails.application.routes.draw do
  mount Parliament::Engine::Engine => "/routes"

  get 'welcome/index'
  root 'welcome#index'
end
