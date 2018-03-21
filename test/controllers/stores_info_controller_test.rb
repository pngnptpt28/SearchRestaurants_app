require 'test_helper'

class StoresInfoControllerTest < ActionDispatch::IntegrationTest
  test "should get name" do
    get stores_info_name_url
    assert_response :success
  end

  test "should get detail" do
    get stores_info_detail_url
    assert_response :success
  end

end
