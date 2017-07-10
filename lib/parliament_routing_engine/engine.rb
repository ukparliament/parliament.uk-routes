module ParliamentRoutingEngine
  class Engine < ::Rails::Engine
    isolate_namespace ParliamentRoutingEngine
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
