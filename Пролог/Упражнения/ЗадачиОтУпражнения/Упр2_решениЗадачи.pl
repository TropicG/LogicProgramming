% Зад 1: Премахва първото срещане на елемент X в L1 и връща списък L2
remove(X, [X | T], T).
remove(X, [H | T], [H | Q]) :- remove(X, T, Q).

% Зад 2: Премахва всяко срещане на X в L1 и резултата се запазва в L2
removeall(_, [], []).
removeall(X, [X | L1], L2) :- removeall(X, L1, L2).
removeall(X, [H | L1], [H | L2]) :- removeall(X, L1, L2), X \= H. 

% Зад 3: Добавя X в L1, за да може да получи нов списък L2
insert(X,L1,L2) :- remove(X, L2, L1).

% Зад 4: От елементите на списък L1, за да се направи пермутация, която се запазва в Result 
permutation([],[]).
permutation([H | L1], Result) :- permutation(L1, Q), insert(H, Q, Result).
% От опашката L1 правим пермутацията и Q, след това към Q добавяме H, за да получим Result

% Зад 5: Проверка за списъка L1 дали е сортиран
lessOrEqual(X,Y) :- X =< Y.
isAscSorted([]).
isAscSorted([_]).
isAscSorted([X, Y | L1]) :- lessOrEqual(X,Y), isAscSorted([Y | L1]).
% Проверяваме всеки две числа в началото на един списък дали са в ред, ако са предаваме нататък списъка

% Зад 6: Проверка дали X е префикс/суфикс на думата W
append([], [], []).
append([], L2, L2).
append([X | L1], L2, [X | Result]) :- append(L1, L2, Result).

preffix(X, W) :- append(X, _, W).
suffix(X, W) :- append(_, X, W).
% Дадено X е префикс/суфикс на думата W, ако съществува някакво _, което може да се append-ва правилно за да може X да бъде суфикс/префикс

% Зад 7: Проверка дали SQ (subsequence) е подредица на L
subsequence([], _).
subsequence([H | SQ], [H | L]) :- subsequence(SQ, L).
subsequence([H | SQ], [HL | L]) :- subsequence([H | SQ], L).
% Дефиницията за подредица е, че не е нужно SQ да се намира в точния си ред в L 
% Ако искаш пък предиката да ти върне true, ако SQ се намира в същия ред в L просто коментирай 37ми ред.