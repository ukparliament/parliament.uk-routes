require 'test_helper'

module Parliament
  module Engine
    class Engine
      class Test < ActiveSupport::TestCase
        test "truth" do
          assert_kind_of Module, parliament_engine
        end
      end
    end
  end
end
