# Connect-Four-Game

A game has been developed using Prolog that allows two players to play Connect Four.

This game takes input from two players (in turn) and allows them to place a nought or a cross (depending on the player) on the board. 

The board has seven columns and six rows.

Each time a player makes a move, the game checks whether both the input and the move are valid. After each successful move, the game checks whether a player has won (i.e., if a player has managed to place four connected noughts or crosses in the same row, column, or diagonal) or if the board is full and the game is a draw. If either condition is met, the game prints an appropriate message to the players.

The output looks like:

```
?- connect4.
Player x enter move: z.
a is not a valid column (must be a number in the range [1-7]).
Player x enter move: 9.
11 is not a valid column (must be a number in the range [1-7]).
Player x enter move: 1.
| | | | | | | |
| | | | | | | |
| | | | | | | |
| | | | | | | |
| | | | | | | |
|x| | | | | | |
---------------
Player o enter move: 2.
| | | | | | | |
| | | | | | | |
| | | | | | | |
| | | | | | | |
| | | | | | | |
|x|o| | | | | |
---------------
.
.
.
Player x enter move: 4.
| | | | | | | |
| | | | | | | |
| | | |x| | | |
| | |x|o| | | |
| |x|x|o| | | |
|x|o|o|o|x| | |
---------------
Player x Wins!
true .

```
However, there is a bug: when a player connects four horizontally in the bottom row, the game continues and does not return true. This only occurs in the bottom row, so I have no clue how to fix it.
