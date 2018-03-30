require 'test_helper'

class RestsControllerTest < ActionDispatch::IntegrationTest
  
    test "should get root" do
        get root_path
        assert_response :success
    end

    test "should get search" do
        get search_path
        assert_response :success
    end

end
