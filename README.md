# Connect Four on Rails

Connect Four playable online or from the console. All code was hand written so
the Minimax algorithm is a little buggy and slow.

## Web Version

![Web Connect Four](https://buddy-connect-four.herokuapp.com/web.png)

[Play Connect Four on Heroku](http://buddy-connect-four.herokuapp.com)

You can swap the mode you are playing in any time using the select. This allow
you to play as PvP for a few moves and then let the AI take over after your
next turn.

## Console Version

![Console Connect Four](https://buddy-connect-four.herokuapp.com/console.png)

To play in the console:

- `rails game:classic` Player vs. Player
- `rails game:easy` Player vs. AI (Random)
- `rails game:moderate` Player vs. AI ()
- `rails game:hard` Player vs. AI (Random)

You can setup a board by sending in a list of play on the first move. For example,
you can paste `[1, 2, 1, 2, 1, 2, 1]` into any move to play those moves.

## Developer Guide

- Remember to run `bundle`
- Run test suite by `rails test`

## Unfinished

- Persist games to database
- Generate a large sample size of games to test AI again

## Known Bugs

- Web: UI randomly switches players when in AI mode
- Web: height of board is larger than needed
- AI: hard AI occasionally misses obvious blocks
- AI: implementation of algorithm is slow

## Resources

- [Wikipedia Connect Four](https://en.wikipedia.org/wiki/Connect_Four)
- [MIT Lecture: Games, Minimax, and Alpha-Beta](https://www.youtube.com/watch?v=STjW3eH0Cik)
- [Minimax Algorithm](https://en.wikipedia.org/wiki/Minimax)
- [Alpha-beta Pruning Variation](https://en.wikipedia.org/wiki/Alpha%E2%80%93beta_pruning)
- [Negamax Variation](https://en.wikipedia.org/wiki/Negamax)
- [Connect Four Example and Tutorial in C++](http://connect4.gamesolver.org/)
- [Connect Four in JavaScript](https://www.roadtolarissa.com/javascript/connect-4-AI/)

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
