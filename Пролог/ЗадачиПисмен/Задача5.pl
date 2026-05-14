/*
  ЗАДАЧА 5:
  Дефиниция:
  Казваме, че списъкът X е екстерзала за списъка от списъци Y, ако:
  1. X има поне един общ елемент с ВСИЧКИ елементи (подсписъци) на Y.
  2. X има поне два общи елемента с НЕЧЕТЕН брой елементи на Y.

  Задача:
  Да се дефинира на Пролог двуместен предикат екстерзала(X, Y), който 
  по даден списък от списъци Y, при презадоволяване (backtracking) 
  генерира всички екстерзали X за Y с възможно най-малка дължина и спира.
*/
elementCommonInAllY(_, []).
elementCommonInAllY(Z, [H | Y]) :- member(M, H), M =:= Z, elementCommonInAllY(Z, Y).

% Условие 1, проверява дали X има общ елемент със всички Y 
hasOneMemberCommonInY(X, Y) :- member(Z,X), elementCommonInAllY(Z,Y).

% Взимаме не подредица от Лист, ще ни е нужно когато искаме да вземем подредица от Y 
subsequence([], _).
subsequence([H | T], [R | Q]) :- subsequence([H | T], Q), H /= R. 
subsequence([H | T], [H | Q]) :- subsequence(T, Q).

len([], 0).
len([H | T], X) :- len(T, Y), N is Y+1.

odd(X) :- X mod 2 =/= 0.

commonElemWithAll(X, _).
commonElemWithAll(X, [H | Y]) :- member(X, H), commonElemWithAll(X, Y). 

% Взимаме такава подредица на Y, която е с нечетна дължина
% Взимаме два елемента на X такива че те да са общите със всичките елементи на нечетната подредица  
hasTwoCommonElementsWithOddCountOfY(X, Y) :- 
    subsequence(SubY, Y),
    len(SubY, SY),
    odd(SY),
    member(X1, X), member(X2, X),
    commonElemWithAll(X1,SubY), commonElemWithAll(X2,SubY).

between(A,B,A) :- A =< B.
between(A,B,X) :- A < B, A1 is A+1, between(A,B,X).

% Слагам генерирането тук, защото се искаше да се генерира списък
genNS(0,0,[]).
genNS(N, S, [H | T]) :-
    N > 0,
    between(0, S, H),
    S1 is S-H,
    N1 is N-1,
    genKS(N1,S1,T).

exterzala(X,Y) :- 
    nat(N),
    nat(S),
    genKS(N,S,X),
    hasOneMemberCommonInY(X,Y),
    hasTwoCommonElementsWithOddCountOfY(X,Y).







