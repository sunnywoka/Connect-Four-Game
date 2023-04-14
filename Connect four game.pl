%Yuekai Wu
% Play Connect-Four predicate
play_connect4 :- startingBoard(Board), connect4(Board, x).

% Definition of an empty board (7 empty colums).
startingBoard([[_,_,_,_,_,_],[_,_,_,_,_,_],[_,_,_,_,_,_],[_,_,_,_,_,_],[_,_,_,_,_,_],[_,_,_,_,_,_],[_,_,_,_,_,_]]).

% Main predicate
connect4(Board, Player) :- player_swap(Player, Player1),win(Board, Player1), write('Player '), write(Player1), write(' Wins!').
connect4(Board, Player1) :-
		write('Player '), write(Player1), write(' enter a move: '),
		get_move(Col, Board, Row),				% Read a column Col from user and calculate Row (!!!! not complete !!!!).
		set(Col, Row, Board, Player1),	% Set the Board at Col, Row to Player1
		print(Board),					% Print out the Board
		%Player2 = Player1				% Swap to other player (!!!! not implemented !!!!).
		player_swap(Player1, Player2),         %swap playereach time
		connect4(Board, Player2).		% Play the next turn.

%swap the player
player_swap(x,o).
player_swap(o,x).

% Get a Column and Row for a player Move
get_move(Col, Board, Row):-
		repeat,		% Repeat
		read(Col),	% Read Column number
		valid_col_placement(Col),

		%Row = 1,	% Find first empty Row (!!!! not implemented !!!!).
					% Validate input       (!!!! not implemented !!!!).
		find_empty(Col, Board, Row).

%Find first empty row
find_empty(Col, Board, Row):-
	nth_item(Col, Board, [A|_]),
	var(A),
	Row = 1.

find_empty(Col, Board, Row):-
	nth_item(Col, Board, [_,A|_]),
	var(A),
	Row = 2.

find_empty(Col, Board, Row):-
	nth_item(Col, Board, [_,_,A|_]),
	var(A),
	Row = 3.

find_empty(Col, Board, Row):-
	nth_item(Col, Board, [_,_,_,A|_]),
	var(A),
	Row = 4.

find_empty(Col, Board, Row):-
	nth_item(Col, Board, [_,_,_,_,A|_]),
	var(A),
	Row = 5.

find_empty(Col, Board, Row):-
	nth_item(Col, Board, [_,_,_,_,_,A|_]),
	var(A),
	Row = 6.


%Check the input Col is in correct range and must a number.
valid_col_placement(Col):-
	member(Col, [1,2,3,4,5,6,7]).

valid_col_placement(Col):-
	number(Col),
	not(member(Col, [1,2,3,4,5,6,7])),
	write(Col),
	write(' is not a valid column (must be a number in the range [1-7]).'), nl,
	write(' Please enter yout move again: '),
	fail.

valid_col_placement(Col):-
	not(number(Col)),
	write(Col),
	write(' is not a valid column (must be a number in the range [1-7]).'), nl,
	write(' Please enter yout move again: '),
	fail.



% Test whether Board is empty at column Col and row Row.
empty(Col, Row, Board) :-
		nth_item(Col, Board, Column),	% Find the column in the board
		nth_item(Row, Column, Item),	% Find the item in the column
		var(Item).						% Check the item is still a variable

% Set the Board at column Col and row Row to Item.
set(Col, Row, Board, Item) :-
	nth_item(Col, Board, Column),	% Find the column in the board
	nth_item(Row, Column, Item).	% Find the item in the board and match with Item

% Get the Item in the Board at column Col and row Row.
gett(Col, Row, Board, Item) :-
	nth_item(Col, Board, Column),	% Find the column in the board
	nth_item(Row, Column, Item),	% Find the item in the column
	nonvar(Item).					% Check it isn't a variable

%check list has how many items are not variables
check_length([],0).
check_length([H|T],N):-
	nonvar(H),
	check_length(T,N1),
	N is N1 +1.
check_length([H|T],N):-
	var(H),
	check_length(T,N).


% Win Conditions (not implemented)
% win in same column
win(Board, Player) :- append(_,[Column|_],Board),
		      check_length(Column, Length),
		      Length > 3,
		      append(_,[Player,Player,Player,Player|_],Column).

%win in same row
win(Board,Player):- append(_,[Column1,Column2,Column3,Column4|_],Board),
	            check_length(Column1, Length),
		    check_length(Column2, Length),
		    check_length(Column3, Length),
		    check_length(Column4, Length),
		    nth_item(Length, Column1, Player),
		    nth_item(Length, Column2, Player),
		    nth_item(Length, Column3, Player),
		    nth_item(Length, Column4, Player).

%win in / dialog
win(Board,Player):- append(_,[Column1,Column2,Column3,Column4|_],Board),
		    check_length(Column1, Length1),
		    check_length(Column2, Length2),
		    check_length(Column3, Length3),
		    check_length(Column4, Length4),
		    Length2 is Length1+1, Length3 is Length2+1, Length4 is Length3+1,
                    nth_item(Length1, Column1, Player),
		    nth_item(Length2, Column2, Player),
		    nth_item(Length3, Column3, Player),
		    nth_item(Length4, Column4, Player).

%win in \ dialog
win(Board,Player):- append(_,[Column1,Column2,Column3,Column4|_],Board),
	            check_length(Column1, Length1),
		    check_length(Column2, Length2),
		    check_length(Column3, Length3),
		    check_length(Column4, Length4),
		    Length2 is Length1-1, Length3 is Length2-1, Length4 is Length3-1,
                    nth_item(Length1, Column1, Player),
		    nth_item(Length2, Column2, Player),
		    nth_item(Length3, Column3, Player),
		    nth_item(Length4, Column4, Player).

% Get the nth item in a list (index starts from 1)
nth_item(1, [H|_], H).
nth_item(N, [_|T], E) :-
		N > 1,
		N1 is N-1,
		nth_item(N1, T, E).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Print predicates (simplified) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Print the Connect-Four Board
print(Board) :- printRows(Board, 6).

% Print Rows
printRows(_, 0) :- write("---------------"),nl.
printRows(Board, N) :-
		N > 0,
		printRow(Board, N),
		N1 is N - 1,
		printRows(Board, N1).

% Print a Row
printRow(Board, Row) :- printCols(Board, Row, 7), nl.

% Print Columns
printCols(_, _, 0) :- write('|').
printCols(Board, Row, Col) :-
		Col > 0,
		Col1 is Col - 1,
		printCols(Board, Row, Col1),
		printItem(Board, Row, Col).

% Print an Item
printItem(Board, Row, Col) :-
		empty(Col, Row, Board),
		write(' |').
printItem(Board, Row, Col) :-
		gett(Col, Row, Board, Item),
		write(Item),
		write('|').








