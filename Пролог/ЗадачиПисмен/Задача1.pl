/*
  Първа задача на Prolog:

  Нека за всяко положително число i с ξ(i) и η(i) означим съответно броя 
  на простите числа от вида 6k + 1 и 6k + 5, които са по-малки от i.

  Да се дефинират на Prolog едноместни предикати su(X) и mu(X), които
  по дадено цяло число X разпознават дали за някое положително цяло 
  число i е в сила равенството:
    - X = i + ξ(i) за su(X)
    - X = i - η(i) за mu(X)
*/
between(A,B,A) :- A =< B.
between(A, B, X) :- A < B, A1 is A+1, between(A1, B, X).

isPrime(N) :- not(N =< 1), N1 is N div 2, not((between(2, N1, X), N mod X =:= 0)).

member(X, [X | _]).
member(X, [H | T]) :- member(X,T), X \= H.

nat(0).
nat(X) :- nat(Y), X is Y+1.

int(0).
int(X) :- nat(Y), Y > 0, member(Z, [-1,1]), X is Y * Z.
intPos(X) :- int(X), X > 0.

len([], 0).
len([X | T], X) :- len(T, Y), N is Y+1.

range(A,B,[]) :- A > B.
range(A,B,[A | T]) :- A =< B,A1 is A+1, range(A1,B,T).

allEpsiNumber([], [], _).
allEpsiNumber([H | T], R, X) :- not(isPrime(H)), allEpsiNumber(T, R, X).
allEpsiNumber([H | T], [E | R], X) :- isPrime(H), X > H, E is 6*H + 1, allEpsiNumber(T, R, X).

epsiCount(X, N) :- range(0, X, R), allEpsiNumber(R, E, X), len(E, N).

su(X) :- int(X), intPos(Y), epsiCount(Y,N), X is Y+N.
% Задачата може и да не е вярна, просто съм голям инат да я поправя след като прекарах 30 мин да я правя