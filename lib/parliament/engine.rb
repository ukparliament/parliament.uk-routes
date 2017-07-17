module Parliament
  module Engine
    class << self
      def load!
        register_rails_files if rails?
      end

      private

      def rails?
        defined?(::Rails)
      end

      def register_rails_files
        require 'parliament/engine/engine'
      end
    end
  end
end

Parliament::Engine.load!
