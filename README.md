# Poker Hand Showdown

### The challenge
Implement a library (in your language of choice) which evaluates who are the winner(s) among several 5 card poker hands.

You only need to implement a subset of the regular poker hands:
- Flush
- Three of a Kind
- One pair
- High Card

#### Input:
Collection of players in the showdown. Including Player Name and 5 Cards (each specifying the card rank and suit of the card). For example:

- Joe, 3H, 4H, 5H, 6H, 8H
- Bob, 3C, 3D, 3S, 8C, 10D
- Sally, AC, 10C, 5C, 2S, 2C

#### Output:
Collection of winning players (more than one in case of a tie). For example:

- Joe

### How to run

In order to use this library you need to require `lib/poker-showdown.rb`. You can then call `PokerShowdown.play` to run a game. For example, in irb:

```
> require './lib/poker-showdown'
> PokerShowdown.play([
    ['Joe',   ['3H', '4H', '5H', '6H', '8H']],
    ['Bob',   ['3C', '3D', '3S', '8C', '10D']],
    ['Sally', ['AC', '10C', '5C', '2S', '2C']]
  ]
```

### How to test

Use RSpec to run the tests.

```
cd poker-showdown
bundle
rspec
```


### Assumptions

- If two hands are tied, e.g. both are a Flush, then compare each hand's highest card to determine the winner. If both highest cards are equal, then compare the second highest cards, and so on.
- If two hands tie with a One Pair, then compare the value of each pair to determine the winner. If equal, then compare highest cards as before. This also applies to Three of a Kind.
