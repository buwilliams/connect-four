require 'test_helper'

class Connect4Test < ActiveSupport::TestCase
  test "true equals true" do
    assert true
  end

  test "draws empty board" do
    c = ConnectFour.new(7, 6)
    expected = "[ ][ ][ ][ ][ ][ ][ ]\n" * 6
    assert_equal(expected, c.render)
  end

  test "draws board with one move" do
    c = ConnectFour.new(7, 6)
    actual_board = c.clean_board
    actual_board[0] = 1
    c.board = actual_board
    expected = "[ ][ ][ ][ ][ ][ ][ ]\n" * 5
    expected += "[x][ ][ ][ ][ ][ ][ ]\n"
    assert_equal(expected, c.render)
  end

  test "draws board with one move in obscure positions" do
    c = ConnectFour.new(7, 6)
    actual_board = c.clean_board
    actual_board[0] = 1
    actual_board[8] = 1
    actual_board[16] = 1
    actual_board[24] = 1
    actual_board[32] = 1
    actual_board[40] = 1
    c.board = actual_board
    expected =  "[ ][ ][ ][ ][ ][x][ ]\n"
    expected += "[ ][ ][ ][ ][x][ ][ ]\n"
    expected += "[ ][ ][ ][x][ ][ ][ ]\n"
    expected += "[ ][ ][x][ ][ ][ ][ ]\n"
    expected += "[ ][x][ ][ ][ ][ ][ ]\n"
    expected += "[x][ ][ ][ ][ ][ ][ ]\n"
    assert_equal(expected, c.render)
  end

  test "draws board with both players" do
    c = ConnectFour.new(7, 6)
    c.move(1)
    c.move(2)
    expected = "[ ][ ][ ][ ][ ][ ][ ]\n" * 5
    expected += "[x][o][ ][ ][ ][ ][ ]\n"
    assert_equal(expected, c.render)
  end

  test "draws board with both players with stacked moves" do
    c = ConnectFour.new(7, 6)
    c.move(1)
    c.move(2)
    c.move(2)
    c.move(1)
    expected = "[ ][ ][ ][ ][ ][ ][ ]\n" * 4
    expected += "[o][x][ ][ ][ ][ ][ ]\n"
    expected += "[x][o][ ][ ][ ][ ][ ]\n"
    assert_equal(expected, c.render)
  end

  test "ensure bounds checking works" do
    c = ConnectFour.new(7, 6)
    10.times { c.move(1) }
    expected =  "[o][ ][ ][ ][ ][ ][ ]\n"
    expected += "[x][ ][ ][ ][ ][ ][ ]\n"
    expected += "[o][ ][ ][ ][ ][ ][ ]\n"
    expected += "[x][ ][ ][ ][ ][ ][ ]\n"
    expected += "[o][ ][ ][ ][ ][ ][ ]\n"
    expected += "[x][ ][ ][ ][ ][ ][ ]\n"
    assert_equal(expected, c.render)
  end

  test "ensure bounds checking works with an additional play" do
    c = ConnectFour.new(7, 6)
    10.times { c.move(1) }
    c.move(2)
    expected =  "[o][ ][ ][ ][ ][ ][ ]\n"
    expected += "[x][ ][ ][ ][ ][ ][ ]\n"
    expected += "[o][ ][ ][ ][ ][ ][ ]\n"
    expected += "[x][ ][ ][ ][ ][ ][ ]\n"
    expected += "[o][ ][ ][ ][ ][ ][ ]\n"
    expected += "[x][x][ ][ ][ ][ ][ ]\n"
    assert_equal(expected, c.render)
  end

  test "ensure bounds checking can fill a board" do
    c = ConnectFour.new(7, 6)
    10.times { c.move(1) }
    10.times { c.move(2) }
    10.times { c.move(3) }
    10.times { c.move(4) }
    10.times { c.move(5) }
    10.times { c.move(6) }
    10.times { c.move(7) }
    expected =  "[o][o][o][o][o][o][o]\n"
    expected += "[x][x][x][x][x][x][x]\n"
    expected += "[o][o][o][o][o][o][o]\n"
    expected += "[x][x][x][x][x][x][x]\n"
    expected += "[o][o][o][o][o][o][o]\n"
    expected += "[x][x][x][x][x][x][x]\n"
    assert_equal(expected, c.render)
  end
end
