/*
Задача 8:
Да се дефинира на Пролог едноместен предикат p, който по даден списък от списъци L разпознава
дали има такава подредица M на L, че конкатенацията на елементите на M да е елемент на L 
*/

% Взимаме подредица от лист 
subsequence([], _).
subsequence([H | T], [Q | L]) :- subsequence([H | T], L), H \= Q.
subsequence([H | T], [H | L]) :- subsequence(T,L).

member(X, [X | _]).
member(X, [H | T]) :- member(X, T), X \= H.

isList([]).
isList([_|_]).

% Позволявани да вземем една редица, която има елементи други листове и да я превърнем в един лист 
flatten([], []).
flatten([H | T], [H | R]) :- not(isList(H)), flatten(T, R).
flatten([H | T], R) :- isList(H), flatten(H, FH), flatten(T, FT), append(FH, FT, R).

% Взимаме подредица S след това я изравняваме като стане FS и проверяваме дали тя е елемент на L 
p(L) :- subsequence(S, L), flattenHelper(S, FS), member(FS, L).