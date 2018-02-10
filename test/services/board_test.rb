require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  test "true equals true" do
    assert true
  end

  test "draws empty board" do
    c = Board.new(7, 6)
    expected = "[ ][ ][ ][ ][ ][ ][ ]\n" * 6
    assert_equal(expected, c.render)
  end

  test "draws board with one move" do
    c = Board.new(7, 6)
    actual_board = c.clean_board
    actual_board[0] = 1
    c.board = actual_board
    expected = "[ ][ ][ ][ ][ ][ ][ ]\n" * 5
    expected += "[x][ ][ ][ ][ ][ ][ ]\n"
    assert_equal(expected, c.render)
  end

  test "draws board with one move in obscure positions" do
    c = Board.new(7, 6)
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
    c = Board.new(7, 6)
    c.move(1)
    c.move(2)
    expected = "[ ][ ][ ][ ][ ][ ][ ]\n" * 5
    expected += "[x][o][ ][ ][ ][ ][ ]\n"
    assert_equal(expected, c.render)
  end

  test "draws board with both players with stacked moves" do
    c = Board.new(7, 6)
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
    c = Board.new(7, 6)
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
    c = Board.new(7, 6)
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
    c = Board.new(7, 6)
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

  test "detects when there are no more moves" do
    no_moves = false
    game_over = ->(result) { no_moves = true }
    c = Board.new(7, 6, game_over)
    10.times { c.move(1) }
    10.times { c.move(2) }
    10.times { c.move(3) }
    10.times { c.move(4) }
    10.times { c.move(5) }
    10.times { c.move(6) }
    10.times { c.move(7) }
    assert_equal(no_moves, true)
  end

  test "detects horizontal win pattern" do
    c = Board.new(7, 6)
    [1, 1, 2, 2, 3, 3, 4].each do |slot|
      c.move(slot)
    end
    expected =  "[ ][ ][ ][ ][ ][ ][ ]\n" * 4
    expected += "[o][o][o][ ][ ][ ][ ]\n"
    expected += "[x][x][x][x][ ][ ][ ]\n"
    assert_equal(expected, c.render)
    actual = c.players_and_coords(Board::WINS[:horizontal], 0, 0)[0]
    assert_equal([1, 1, 1, 1], actual)
  end

  test "detects horizontal out of bounds" do
    c = Board.new(7, 6)
    [10, 10, 11, 11, 12, 12, 13].each do |slot|
      c.move(slot)
    end
    expected =  "[ ][ ][ ][ ][ ][ ][ ]\n" * 6
    assert_equal(expected, c.render)
    actual = c.players_and_coords(Board::WINS[:horizontal], 0, 0)[0]
    assert_equal([nil, nil, nil, nil], actual)
  end

  test "detects veritcal win pattern" do
    c = Board.new(7, 6)
    [1, 2, 1, 2, 1, 2, 1].each do |slot|
      c.move(slot)
    end
    expected =  "[ ][ ][ ][ ][ ][ ][ ]\n" * 2
    expected += "[x][ ][ ][ ][ ][ ][ ]\n"
    expected += "[x][o][ ][ ][ ][ ][ ]\n"
    expected += "[x][o][ ][ ][ ][ ][ ]\n"
    expected += "[x][o][ ][ ][ ][ ][ ]\n"
    assert_equal(expected, c.render)
    actual = c.players_and_coords(Board::WINS[:vertical], 0, 0)[0]
    assert_equal([1, 1, 1, 1], actual)
  end

  test "detects diaginal right win pattern" do
    c = Board.new(7, 6)
    [1, 2, 2, 3, 3, 4, 3, 4, 4, 1, 4].each do |slot|
      c.move(slot)
    end
    expected =  "[ ][ ][ ][ ][ ][ ][ ]\n"
    expected += "[ ][ ][ ][ ][ ][ ][ ]\n"
    expected += "[ ][ ][ ][x][ ][ ][ ]\n"
    expected += "[ ][ ][x][x][ ][ ][ ]\n"
    expected += "[o][x][x][o][ ][ ][ ]\n"
    expected += "[x][o][o][o][ ][ ][ ]\n"
    assert_equal(expected, c.render)
    actual = c.players_and_coords(Board::WINS[:diaginal_right], 0, 0)[0]
    assert_equal([1, 1, 1, 1], actual)
  end

  test "detects diaginal left win pattern" do
    c = Board.new(7, 6)
    [4, 3, 3, 2, 2, 1, 2, 1, 1, 4, 1].each do |slot|
      c.move(slot)
    end
    expected =  "[ ][ ][ ][ ][ ][ ][ ]\n"
    expected += "[ ][ ][ ][ ][ ][ ][ ]\n"
    expected += "[x][ ][ ][ ][ ][ ][ ]\n"
    expected += "[x][x][ ][ ][ ][ ][ ]\n"
    expected += "[o][x][x][o][ ][ ][ ]\n"
    expected += "[o][o][o][x][ ][ ][ ]\n"
    assert_equal(expected, c.render)
    actual = c.players_and_coords(Board::WINS[:diaginal_left], 3, 0)
    assert_equal([1, 1, 1, 1], actual[0])
    assert_equal([3, 0], actual[1][0])
    assert_equal([2, 1], actual[1][1])
    assert_equal([1, 2], actual[1][2])
    assert_equal([0, 3], actual[1][3])
  end

  test "detects win condition" do
    game = [nil, nil]
    c = Board.new(7, 6, ->(result){ game = result })
    [4, 3, 3, 2, 2, 1, 2, 1, 1, 4].each do |slot|
      c.move(slot)
    end
    c.move(1) # win condition
    expected =  "[ ][ ][ ][ ][ ][ ][ ]\n"
    expected += "[ ][ ][ ][ ][ ][ ][ ]\n"
    expected += "[x][ ][ ][ ][ ][ ][ ]\n"
    expected += "[x][x][ ][ ][ ][ ][ ]\n"
    expected += "[o][x][x][o][ ][ ][ ]\n"
    expected += "[o][o][o][x][ ][ ][ ]\n"
    assert_equal(expected, c.render)
    assert_equal(1, game[0])
    assert_equal([3, 0], game[1][0])
    assert_equal([2, 1], game[1][1])
    assert_equal([1, 2], game[1][2])
    assert_equal([0, 3], game[1][3])
  end
end
