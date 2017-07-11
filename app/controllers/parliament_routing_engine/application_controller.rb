module Parliament
  module Engine
    class Engine
      class ApplicationController < ActionController::Base
        protect_from_forgery with: :exception
      end
    end
  end
end
