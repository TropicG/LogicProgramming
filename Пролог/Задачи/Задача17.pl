/*
  Зад. 17. Нека G е неориентиран граф. Множеството от върховете на G е
  представено със списък V от върховете, всяко ребро e е представено
  с двуелементен списък на краищата му, а множеството от ребрата на G
  е представено със списък E от ребрата.
  
  Да се дефинира на Пролог предикат:
  
  а) con(V, E), който разпознава дали представеният с V и E граф
     е свързан.
     
  б) crit(V, E, X), който по дадени V и E на свързан граф генерира
     в X списък на всички върхове, чието отстраняване води до граф,
     който не е свързан.
*/
member(X, [X | _]).
member(X, [H | T]) :- member(X, T), X \= H.

append([], L2, L2).
append([H | L1], L2, [H | R]) :- append(L1, L2, R).

reversed([], []).
reversed([H | T], R) :- reversed(T, RT), append(RT, [H], R).

remove(X, [], []).
remove(X, [X | T], R) :- remove(X, T, R).
remove(X, [H | T], [H | R]) :- remove(X, T, R), X \= H. 

edge(E, X, Y) :- member([X,Y], E), member([Y,X], E).

path([V,E], A, B, Path) :- pathHelper([V,E], A, B, [], Path).
pathHelper(_, B, B, Visited, Path) :- reversed([B | Visited], Path).
pathHelper([V,E], A, B, Visited, Path) :- A \= B, edge(E, A, C), not(member(C, Visited)), pathHelper([V,E], C, B, [A | Visited], Path).

con(V,E) :- not((member(A,V), member(B,V), A \= B, not(path([V,E], A, B, _)))).

subset([], _).
subset([H | T], [Q | R]) :- subset([H | T], R). 
subset([H | T], [H | R]) :- subset(T, R).

% Трябва [V,E] да е свързан граф и съществува такова подмножество от V (което трябва да е X),
% такова че когато се премахне от V ще се получи NewV (тоест нови върхове) и с тези нови върхове 
% графът не трябва да е свързан
crit(V, E, X) :- con(V,E), subset(X, V), remove(X, V, NewV) ,not(con(NewV, E)).