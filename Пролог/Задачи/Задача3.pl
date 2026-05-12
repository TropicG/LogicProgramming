/*
ЗАДАЧА 3:
Опишете представяне на неориентиран граф. Напишете програма на Пролог,
която по даден неориентран граф разпознава дали той е свързан и ацикличен
*/

% проверка дали даден елемент X е в листа 
member(X, [X | _]).
member(X, [H | L]) :- member(X, L), X =\ H.

% Ръб междy X и Y съществува ако [X,Y] и [Y,X] са части от ръбовете
edge([V,E], X, Y) :- member([X,Y], E), member([Y,E], E).

len([], 0).
len([H | L], N) :- len(L, N1), N is N1 + 1. 

append([], L2, L2).
append([H | L1], L2, [H | Result]) :- append(L1, L2, Result).

reverse([H | T], R) :- reverse(T, RT), append(RT, [H], R).

% търсене на пътя между два върха в един Path
path(G, A, B, Path) :- path_helper(G, A, B, [], Path).
path_helper(_, B, B, Visited, Path) :- reverse([B | Visited], Path).
path_helper(G, A, B, Visited, Path) :- A \= B, edge(G, A, C), not(member(C, Visited)), path(G, C, B, [A | Visited], Path).

hasCycle([V,E]) :- edge([V,E],A,B), path([V,E], A, B, Path), len(Path, N), N > 2.

isConnected([V,E]) :- not((member(A,V), member(B,V), A\=B, not(path([V,E], A, B, _)))).

isConnectedAcyclical([V,E]) :- isConnected([V,E]), not(hasCycle([V,E])).