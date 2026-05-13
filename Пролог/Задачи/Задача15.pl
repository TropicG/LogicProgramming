/*
  Задача 15:
Да се дефинира на Пролог предикат p(X,Y), който по даден списък от числа X и списък от списъци T
проверява дали са изпълнеи следните три условия:
1) X може да се представи като конкатенация на два елемента на Y 
2) X има четен брой елементи
3) сумата от елементите на X е последния елемент на елемент от Y
*/
append([], L2, L2).
append([H | L1], L2, [H | Result]) :- append(L1, L2, Result).

member(X, [ X | _ ]).
member(X, [H | T]) :- member(X, T), X \= H.

% Ако имаме такъв елемент от R и Z от Y, такива че като се конкатенират да са точно X
condition1(X,Y) :- member(R, Y), member(Z, Y), append(R,Z,X).

len([], 0).
len([X | T], N) :- len(T, N1), N is N1+1.

% Дължината на X да е чета
condition2(X) :- len(X, N), N mod 2 =:= 0.

sum([X], X).
sum([X | T], S) :- sum(T, S1), S is S1+X.

last(X, [X]).
last(X, [H | T]) :- last(X, T).

% Сумата от елементите на X да съвпада с последния елемент на някакъв списък Z взет от Y
condition3(X, Y) :- sum(X, S), member(Z, Y), last(S, Z).

p(X,Y) :- condition1(X,Y), condition2(X), condition3(X,Y).