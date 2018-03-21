require 'test_helper'

class StoresInfoControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get root_path
    assert_response :success
  end
  
  test "should get name" do
    post name_path
    assert_response :success
  end

  test "should get detail" do
    get detail_path
    assert_response :success
  end

end
