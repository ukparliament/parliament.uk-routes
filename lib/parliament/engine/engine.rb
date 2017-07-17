module Parliament
  module Engine
    class Engine < ::Rails::Engine
    # Parliament::Engine::Engine class defines routes for host application
    # @since 0.0.1
      config.generators do |g|
        g.test_framework :rspec
      end
    end
  end
end
