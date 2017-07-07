require 'test_helper'

module ParliamentRoutingEngine
  class FailuresControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get failures_index_url
      assert_response :success
    end

  end
end
