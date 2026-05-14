/*
  Първа задача на Prolog

  Редицата {a_n} за n = 0, 1, ... се дефинира рекурентно:

  Вариант 1:
  a_n = 5 * (a_{n-1})^2 + 3 * (a_{n-2})^3
  a_0 = 0
  a_1 = 1

  Вариант 2:
  a_n = 3 * (a_{n-1})^3 + 2 * (a_{n-2})^2
  a_0 = 0
  a_1 = 1

  Задача:
  Да се дефинира на Prolog предикат p(A), който при дадено естествено число A 
  успява точно тогава, когато то НЕ е елемент на редицата {a_n}.
*/

var1(0,0).
var1(1,1).
var1(N, Value) :- var1_helper(2, N, 0, 1, Value).

var1_helper(TargetIndex, TargetIndex, Prev2, Prev1, Value) :-
    Value is 3*(Prev1^3) + 2*(Prev2^2).

var1_helper(CurrentIndex, TargetIndex, Prev2, Prev1, Value) :-
    CurrentIndex < TargetIndex,
    NextValue is 3*(Prev1^3) + 2*(Prev2^2),
    NextIndex is Current+1,
    var1_helper(NextIndex, TargetIndex, Prev1, NextValue, Value).

nat(0).
nat(X) :- nat(Y), X is Y+1.

% Вариант 1
% А е натуралйно число и не съществува такъв индекс на редицата, че стойността да е равно на А
p1(A) :- nat(A), not(nat(X), var1(X, A)).


var2(0,0).
var2(1,1).
var2(N, Value) :- var2(2, N, 0, 1, Value).

var2_helper(N, N, Prev2, Prev1, Value) :-
    Value is 3*(Prev1^3) + 2*(Prev2^2).

var2_helper(CurrentIndex, N, Prev2, Prev1, Value) :-
    CurrentIndex < N,
    NextValue is 3*(Prev1^3) + 2*(Prev2^2),
    NextIndex is CurrentIndex+1,
    var2_helper(NextIndex, N, Prev1, NextValue, Value).

% Вариант2
p2(A) :- nat(A), not(nat(X), var2(X, A)).