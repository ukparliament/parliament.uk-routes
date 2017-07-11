Rails.application.routes.draw do
  mount Parliament::Engine::Engine => "/parliament_engine"

  get 'welcome/index'
  root 'welcome#index'
end
