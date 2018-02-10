# Connect Four on Rails

The classic game we grew up playing in the US. You can play either from the
terminal or play online. See the instructions below to get started.

## Level 1 - Console

- `rails game:standard`

## Level 2 - Dumb AI

- `rails game:dumb`

## Level 3 - Heroku / SPA

- (url goes here)

## Boss Level - Advanced AI

- `rails game:expert`

## Running Tests

- `rails test`

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
