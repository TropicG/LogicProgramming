/*
ЗАДАЧА 2:
Да се дефинира на Пролог двуместен предикат, който по дадени две 
цели числа разпознава дали те имат едни и същи прости делители.

Пример: 
- За 12 (делители 2, 3) и 18 (делители 2, 3) -> true.
- За 12 (делители 2, 3) и 10 (делители 2, 5) -> false.
*/

between(A,B,A) :- A =< B.
between(A,B,X) :- A < B, A1 is A + 1, between(A1,B,X).

isPrime(1).
isPrime(P) :- P > 1, P1 is P div 2, not((between(2, P1, M), P mod M =:= 0)). 

allDivideNumber(_, []).
allDivideNumber(X, [H | L]) :- X mod H =:= 0, allDivideNumber(X, L).

allPrimeDivsForNumber(X,S, []) :- S > X.
allPrimeDivsForNumber(X, S, L) :- S =< X, S1 is S+1, allPrimeDivsForNumber(X, S1, L).
allPrimeDivsForNumber(X, S, [S | L]) :- S =< X, X mod S =:= 0, isPrime(S), S1 is S+1, allPrimeDivsForNumber(X,S1,L).

samePrimeDivs(X,Y) :- allPrimeDivsForNumber(X,2,L), allDivideNumber(Y, L).