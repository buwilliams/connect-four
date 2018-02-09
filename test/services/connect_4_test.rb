require 'test_helper'

class Connect4Test < ActiveSupport::TestCase
  test "true equals true" do
    assert true
  end

  test "draws empty board" do
    connect = ConnectFour.new(7, 6)
    expected = "[ ][ ][ ][ ][ ][ ][ ]\n" * 6
    assert_equal(expected, connect.render)
  end
end
