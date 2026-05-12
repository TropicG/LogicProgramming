/*
Задача 10:
Да се дефинира на Пролог предиакт p(X,Y), който по даден списък от числа X при преудовлетворяване 
дава в Y всички разделяния на X. Разделение на X е такъв списък [X1,X2, ..., XN], че конкатенацията 
на списъците X1,X2,....,Xn е X.

С други думи искат да имплементираш split предикати от упражнения
*/
isList([]).
isList([_|_]).

append([], L2, L2).
append([H | L1], L2, [H | R]) :- append(L1, L2, R).

split([], []).
split(L, [X | R]) :- append(X, Y, L), X \= [], split(Y,R).

flatten([], []).
flatten([H | T], [H | R]) :- not(isList(H)), flatten(T, R).
flatten([H | T], R) :- isList(H), flatten(H, FH), flatten(T, FT), append(FH, FT, R).

% Раздробяваме съдържанието на листа X в листа Y и след това ако бъде изравнен Y трябва да бъде X
p(X, Y) :- split(X,Y), flatten(Y, X).