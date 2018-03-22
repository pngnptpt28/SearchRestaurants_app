require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @rest = Rest.new(id: "a1", name: "example")
  end

  test "should be valid" do
    assert @rest.valid?
  end
end