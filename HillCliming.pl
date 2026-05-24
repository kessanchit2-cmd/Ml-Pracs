% =====================================================
% 8 Puzzle Problem using Hill Climbing in Prolog
% =====================================================

% -----------------------------
% Goal State
% -----------------------------
goal([1,2,3,
      4,5,6,
      7,8,0]).

% -----------------------------
% Heuristic Function
% Number of misplaced tiles
% -----------------------------
heuristic(State, H) :-
    goal(Goal),
    misplaced_tiles(State, Goal, H).

misplaced_tiles([], [], 0).

% Ignore blank tile
misplaced_tiles([0|T1], [_|T2], H) :-
    misplaced_tiles(T1, T2, H).

% Correct position
misplaced_tiles([X|T1], [X|T2], H) :-
    X \= 0,
    misplaced_tiles(T1, T2, H).

% Misplaced tile
misplaced_tiles([X|T1], [Y|T2], H) :-
    X \= Y,
    X \= 0,
    misplaced_tiles(T1, T2, H1),
    H is H1 + 1.

% -----------------------------
% Move Generator
% -----------------------------
move(State, NewState) :-
    nth0(Pos, State, 0),
    neighbor(Pos, NewPos),
    swap(State, Pos, NewPos, NewState).

% -----------------------------
% Valid Neighbor Positions
% -----------------------------

neighbor(0,1).
neighbor(0,3).

neighbor(1,0).
neighbor(1,2).
neighbor(1,4).

neighbor(2,1).
neighbor(2,5).

neighbor(3,0).
neighbor(3,4).
neighbor(3,6).

neighbor(4,1).
neighbor(4,3).
neighbor(4,5).
neighbor(4,7).

neighbor(5,2).
neighbor(5,4).
neighbor(5,8).

neighbor(6,3).
neighbor(6,7).

neighbor(7,4).
neighbor(7,6).
neighbor(7,8).

neighbor(8,5).
neighbor(8,7).

% -----------------------------
% Swap Elements
% -----------------------------
swap(List, I, J, NewList) :-
    nth0(I, List, ElemI),
    nth0(J, List, ElemJ),
    set_element(List, I, ElemJ, TempList),
    set_element(TempList, J, ElemI, NewList).

set_element([_|T], 0, X, [X|T]).

set_element([H|T], I, X, [H|R]) :-
    I > 0,
    I1 is I - 1,
    set_element(T, I1, X, R).

% -----------------------------
% Hill Climbing Algorithm
% -----------------------------

% Goal reached
hill_climb(State, _) :-
    heuristic(State, 0),
    write('Goal State Reached'), nl,
    write(State), nl.

% Continue searching
hill_climb(State, Visited) :-

    findall(Next,
        (
            move(State, Next),
            \+ member(Next, Visited)
        ),
        Neighbors),

    best_neighbor(Neighbors, Best),

    heuristic(State, H1),
    heuristic(Best, H2),

    H2 =< H1,

    write('Current State: '), write(State), nl,
    write('Best Next State: '), write(Best), nl,
    write('Heuristic: '), write(H2), nl, nl,

    hill_climb(Best, [Best|Visited]).

% -----------------------------
% Find Best Neighbor
% -----------------------------
best_neighbor([H], H).

best_neighbor([H|T], Best) :-
    best_neighbor(T, Temp),

    heuristic(H, H1),
    heuristic(Temp, H2),

    (
        H1 =< H2 ->
        Best = H
        ;
        Best = Temp
    ).

% -----------------------------
% Start Predicate
% -----------------------------
solve :-

    Start = [1,2,3,
             4,5,6,
             7,0,8],

    write('Initial State: '), nl,
    write(Start), nl, nl,

    hill_climb(Start, [Start]).