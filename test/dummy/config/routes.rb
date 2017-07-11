Rails.application.routes.draw do
  mount Parliament::Engine::BaseEngine => "/parliament_engine"

  get 'welcome/index'
  root 'welcome#index'
end
