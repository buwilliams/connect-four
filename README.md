# Connect Four on Rails

Connect Four playable online or from the console.

## Web Version

![Web Connect Four](https://buddy-connect-four.herokuapp.com/web.png?v=1)

[Play Connect Four on Heroku](http://buddy-connect-four.herokuapp.com)

You can swap the mode you are playing in any time using the select. This allow
you to play as PvP for a few moves and then let the AI take over after your
next turn.

## Console Version

![Console Connect Four](https://buddy-connect-four.herokuapp.com/console.png?v=1)

To play in the console:

- `rails game:classic` Player vs. Player
- `rails game:easy` Player vs. AI (Random)
- `rails game:moderate` Player vs. AI (Depth=2)
- `rails game:hard` Player vs. AI (Depth=3)

You can setup a board by sending in a list of play on the first move. For example,
you can paste `[1, 2, 1, 2, 1, 2, 1]` into any move to play those moves.

## Developer Guide

- Remember to run `bundle`
- Run test suite by `rails test`
- Start server by `rails s`

Interesting code:

- [Board](app/services/board.rb)
- [BasicAi](app/services/basic_ai.rb)
- [ConnectFour Console](app/services/connect_four.rb)
- [Rake Game Task](lib/tasks/game.rake)
- [Connect Four Controller](app/controllers/connect_four_controller.rb)
- [Connect Four in Vue.js](app/views/connect_four/index.html.slim)
- [Tests](test/services)

## Improvements

- Persist games to database
- Implement Alpha-Beta pruning to improve recursion costs
- Add scoring for 2 and 3 matching groups that have a possible four slot win
  or loss preferring the win
- DRY BasicAi `.lookAhead()` and `.scoreBoard()` methods
- Improve interface for Board.detect_win by creating a BoardState Class,
- potentially add some sort of Coordinates Class to remove some of the
  complexity of the Board class.
- Implement an AI based on [Monte Carlo Tree Search](https://en.wikipedia.org/wiki/Monte_Carlo_tree_search)

## Known Bugs

- AI: hard AI occasionally misses obvious blocks (better scoring solves this)

## Resources

- [Wikipedia Connect Four](https://en.wikipedia.org/wiki/Connect_Four)
- [MIT Lecture: Games, Minimax, and Alpha-Beta](https://www.youtube.com/watch?v=STjW3eH0Cik)
- [Minimax Algorithm](https://en.wikipedia.org/wiki/Minimax)
- [Alpha-beta Pruning Variation](https://en.wikipedia.org/wiki/Alpha%E2%80%93beta_pruning)
- [Negamax Variation](https://en.wikipedia.org/wiki/Negamax)
- [Connect Four Example and Tutorial in C++](http://connect4.gamesolver.org/)
- [Connect Four in JavaScript](https://www.roadtolarissa.com/javascript/connect-4-AI/)
- [Monte Carlo Tree Search](https://en.wikipedia.org/wiki/Monte_Carlo_tree_search)

## Project Goals

- Level 1: Build a playable game of Connect 4 with 2 players, a command line
  interface being fine.  Should have player moves, win detection logic,
  tie detection, etc.  
- Level 2: Implement a standard “AI” for the computer player. A standard
  computer opponent should block a human from winning when able to, but
  plays more ad hoc and does not operate with an advanced strategy.
- Level 3:  Make it playable online (Heroku or similar) with a SPA web
  interface, games persisting to a database,  etc.
- `Boss Level` (Bonus): the computer player's decision engine should have
  a setting for smarter vs standard opponent. The smarter version should
  employ any sort of intelligent strategy or look-ahead approach you choose,
  and be able to win most times (assuming it goes first and it’s not playing
  against a player with the same strategy), though it does not have to play
  mathematically perfectly.
