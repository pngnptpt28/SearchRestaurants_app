require 'test_helper'

class RestsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get rests_show_url
    assert_response :success
  end

end
