/*
  ЗАДАЧА 6:  
  Дърво се нарича краен неориентиран свързан и ацикличен граф. 
  За един списък от списъци [V, E] ще казваме, че представя 
  неориентирания граф G, ако V е списък от всички върхове на G 
  и {v, w} е ребро в G тогава и само тогава, когато [v, w] 
  е елемент на E.
  
  Да се дефинира на Пролог предикат art_tree(V, E), който по 
  дадено представяне [V, E] на краен неориентиран граф разпознава 
  дали има такава двойка върхове v и w, че [V, E + [v, w]] да е 
  представяне на дърво, където E + [v, w] е списъкът, получен от E 
  с добавянето на елемента [v, w].
*/

% Според мен идеята на задачата е да се провери дали съществуват такива два върха v и w
% че ако се направи ръб между тях това ще се получи едно дърво 
member(X, [X | _]).
member(X, [H | T]) :- member(X, T), X \= H.

edge(E, X, Y) :- member([X,Y], E), member([Y,X], E).

append([], L2, L2).
append([H | L1], L2, [H | R]) :- append(L1, L2, R).

reversed([], []).
reversed([H | T], R) :- reversed(T, TR), append(TR, [H], R).

path([V,E], A, B, Path) :- pathHelper([V,E], A, B, [], Path).
pathHelper(_, B, B, Visited, Path) :- reversed([B | Visited], Path).
pathHelper([V,E], A, B, Visited, Path) :- A \= B, edge(E, A, C), not(member(C, Visited)), pathHelper([V,E], C, B, [A | Visited], Path).

len([], 0).
len([X | T], N) :- len(T, Y), N is Y+1.

hasCycle([V,E]) :- edge(E, A, B), path([V,E], A, B, Path), len(Path, N), N > 2.

isConnected([V,E]) :- not((member(A, V), member(B, V), A \= B, not(path([V,E], A, B, _)))).

% Идеята е да има два такива върха, че ако се свържат създаденият граф да няма цикъл, но да бъде свързан
art_tree(V,E) :- member(U, V), member(W, V), not(hasCycle([V, [ [U,W], [W,U] | E]])),  isConnected([V, [ [U,W], [W,U] | E]]).

