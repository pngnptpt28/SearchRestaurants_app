require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @rest = Rest.new(id: "a1", name: "example")
  end

  # 有効か
  test "should be valid" do
    assert @rest.valid?
  end
end