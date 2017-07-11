module Parliament
  module Engine
    class BaseEngine < ::Rails::Engine
      isolate_namespace Parliament::Engine

      config.generators do |g|
        g.test_framework :rspec
      end
    end
  end
end
