require 'test_helper'

class Connect4Test < ActiveSupport::TestCase
  test "true equals true" do
    assert true
  end

  test "draws empty board" do
    actual = Connect4.new(7, 6).render
    expected = "[ ][ ][ ][ ][ ][ ][ ]\n" * 6
    assert_equal(expected, actual)
  end
end
