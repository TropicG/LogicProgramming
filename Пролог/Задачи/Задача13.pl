/*
  Задача 13:
Да се дефинира на пролог предикат p(X), който при даден списък от списъци X е верен, ако в X има единствен елемент Y,
такъв че X и Y нямат общи елементи
*/
member(X, [X | _]).
member(X, [H | T]) :- member(X, T), X \= H.

isList([]).
isList([_|_]).

% дефиниране на нулево сечение между списъци
section(Y,X) :- not(isList(Y)), not(member(Y,X)).
section(Y,X) :- isList(Y), not((member(Z, Y), member(Z, X))).

allSectionList([],_).
allSectionList([H | T], X) :- not(isList(H)), section(H,X), allSectionList(T,X).
allSectionList([H | T], X) :- isList(H), section(H, X), allSectionList(T, X).

% Недовършенаа: трябва да я довършиш


p(X) :- member(Y,X), allSectionList(Y, X), not((member(Z, X), Z \= Y, allSectionList(Z,X))).