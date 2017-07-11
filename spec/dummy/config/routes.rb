Rails.application.routes.draw do
  mount Parliament::Engine::Engine => "/parliament-engine"

  get 'welcome/index'
  root 'welcome#index'
end
