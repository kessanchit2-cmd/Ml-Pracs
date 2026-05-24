% Tic-Tac-Toe BFS Implementation in Prolog

% Initial board
initial_state([e,e,e,
               e,e,e,
               e,e,e]).

% Goal state (example: X wins)
goal_state([x,x,x,
            _,_,_,
            _,_,_]).

% Move generation
move(Board, NewBoard, Player) :-
    nth0(Index, Board, e),      % find empty position
    replace(Board, Index, Player, NewBoard).

% Replace element in list
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]) :-
    I > 0,
    I1 is I - 1,
    replace(T, I1, X, R).

% BFS Algorithm
bfs([[State|Path]|_], [State|Path]) :-
    goal_state(State).

bfs([[State|Path]|Rest], Solution) :-
    findall([Next,State|Path],
            move(State, Next, x),
            NewPaths),
    append(Rest, NewPaths, Queue),
    bfs(Queue, Solution).

% Start BFS
solve(Solution) :-
    initial_state(State),
    bfs([[State]], Solution).