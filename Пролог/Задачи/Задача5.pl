/*
Задача 5:
Ако E е списък от списъци с дължина 2, да означим с G(E) ориентирания граф, 
в който няма изолирани върхове и от върха u към върха v има ребро 
точно тогава, когато [u, v] е елемент на списъка E. 

Да се дефинира на Prolog предикат p(E, n, u, v), който по даден списък 
от двуелементни списъци E, естествено число n и върхове u и v от графа G(E) 
проверява дали в G(E) има път от u до v с дължина не по-голяма от n.
*/

len([], 0).
len([H | L], N) :- len(L, N1), N is N1 + 1.

member(X, [X | _]).
member(X, [H | T]) :- member(X, T), X \= H.

% Вика се да се провери пътя между V -> U и се запазва стойността в Path, като послед гледаме колко е дълъг Path 
p(E,N,U,V) :- path(E, U, V, [], Path), len(Path, K), K =< N. 
p(E, N, U, V) :- U =:= V, N >= 0. 
% ако U=V, тогава искаме само N да е по-голямо от 0

% Когато има връх в посока Current(U) -> Target, Path ще стане Visited (трябва ни само броя на посетени върхове)
path(E, Current, Target, Visited, [Current | Visited]) :- member([Current, Target], E).

% Проверявца дали от сегашният връх Current има връзка към друг връх Next, който не е бил посещавам
% Ако такъв връх съществува се вика отново Path като current ще стане Next и Current Ще бъде добавен към visited
path(E, Current, Target, Visited, Path) :- 
    Current \= Target,
    member([Current, Next], E),
    not(member(Next, Visited)),
    path(E, Next, Target, [Current | Visited], Path).
