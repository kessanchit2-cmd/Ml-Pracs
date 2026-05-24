% ============================================
% Water Jug Problem using DFS in Prolog
% ============================================

% Goal State
goal(2,_).

% DFS Algorithm
dfs(State, Visited) :-

    goal_state(State),

    write('Goal Reached: '),
    write(State), nl.

dfs(State, Visited) :-

    move(State, Next),

    \+ member(Next, Visited),

    write('Current State: '),
    write(Next), nl,

    dfs(Next, [Next|Visited]).

% Goal Check
goal_state((2,_)).

% --------------------------------
% Possible Moves
% --------------------------------

% Fill Jug A (4L)
move((_,Y), (4,Y)).

% Fill Jug B (3L)
move((X,_), (X,3)).

% Empty Jug A
move((_,Y), (0,Y)).

% Empty Jug B
move((X,_), (X,0)).

% Pour Jug A -> Jug B
move((X,Y), (NewX,NewY)) :-
    X > 0,
    Y < 3,
    Transfer is min(X, 3-Y),
    NewX is X - Transfer,
    NewY is Y + Transfer.

% Pour Jug B -> Jug A
move((X,Y), (NewX,NewY)) :-
    Y > 0,
    X < 4,
    Transfer is min(Y, 4-X),
    NewY is Y - Transfer,
    NewX is X + Transfer.

% --------------------------------
% Start Predicate
% --------------------------------

solve :-

    InitialState = (0,0),

    write('Initial State: '),
    write(InitialState), nl,

    dfs(InitialState, [InitialState]).