% Зад 1: Да се изравни листа L, тоест ако L = [[1,2,3], [4], [5,6]] да стане [1,2,3,4,5,6]
isList([]).
isList([_ | _]).

append([], L2, L2).
append([H | L1], L2, [H | Result]) :- append(L1, L2, Result).

flattenHelper([], []).
flattenHelper(X, [X]) :- not(isList(X)).
flattenHelper([H | T], FL) :- flattenHelper(H, FH), flattenHelper(T, FT), append(FH, FT, FL). 
flatten(L, FL) :- isList(L), flattenHelper(L, FL).
% Идеята е листа L да го направим изравним в FL, за да стане това се предава на helper функция, за да е по лесно
% В flattenHelper се взима главата H и опашката T на L и се подават отновно на flattenHelper-a за да направят изравнени FH и FT 
% Накрая изравнените FH и FT се append-ват за да получат директно търсената от нас FL (тоест изравненият оригинално подаден списък)

% Зад 2: Съдържанието на един списък L, се прави прави на подсписъци 
isEmptyList([]).
split([], []).
split(L, [X | R]) :- append(X, Y, L), not(isEmptyList(X)), split(Y,R).

% Зад 3: Сбора на елементите на даден списък L да бъде равно на N 
between(A,B,A) :- A =< B.
between(A,B,X) :- A < B, A1 is A+1, between(A1,B,X).

sum(0,[]).
sum(N, [H | T]) :- N > 0, between(1, N, H), N1 is N - H, sum(N1, T).
% Взима се число от [1, N] което ще бъде добавено към списъка, след това останлите числа трябва да имат сумата N - H, за да може списъка да има нужната обща сума и се предава напред.

% Зад 4: Генериране на дърво
tree(0, []).
tree(N, [A,B]) :-
        N > 0,
        N1 is N - 1,
        between(0, N1, M),
        K is N1 - M,
        tree(K, A),
        tree(M, B).
% N е броят на върховете на дървото, а A и B са двете поддървената от корена на дървото
% Сваля се бройката на N с едно и се взима числа между N1 и N, то ще обозначава колко броя върхове ще има поддърво B 
% След това се изчислява брой 

% Зад 5: Съществува ли ръб между два върха в един граф
% Важни означения:
% G = <V,E> (обозначено с [V,E])
% V = [a,b,c,d] това е листа, който съдържа всички върхове на графа 
% Е = [[a,d], [a,d], [c,a]] това е листа, който съдържа всички ръбове между върховете на графа 
member(X, [X | _]).
member(X, [H | T]) :- member(X, T), X \= H.

edge([V,E], X, Y) :- member([X,Y], E), member([Y,X], E).
% В един неориентиран граф, <X,Y> ще съществува като ръб ако <X,Y> и <Y,X> е част от множеството E 

% Зад 6: Да се намери дали има път между два върха в един граф 
append([], L2, L2).
append([H | L1], L2, [H | Result]) :- append(L1, L2, Result).

reverse([H | L1], Reversed) :- reverse(L1, LR), append(LR, [H], Reversed).

path(G, A, B, Path) :- path_helper(G,A,B,[],Path).
path_helper(_, B, B, Visited, Path) :- reverse([B | Visited], Path).
path_helper(G, A, B, Visited, Path) :- A =\ B, edge(G, A, C), not(member(C,Visited)), path(G, C, B, [A | Visited], Path).

% G е комбинация от [V,E], A и B са върховете между които трябва да търсим дали има път, във Visited Поставяме всички върхове които сме поситили да не зацикляме, накрая във Path ще съдържат всички върхове през които сме минали
% A и B трябва да са различни от други и да съществува някакъв съсед на C на А от графът G, който вече не е посетен (not(member(C,Visited))) след това викаме path наново като добавяме A към visisted (тоест върха който сега гледаме го добавяме там) и подаваме следващата точка C да се търси от нея
% Когато сме намерили търсеният от нас връх (B,B) просто reverse-ваме Visited да съвпада с Path 

% Зад 7: Да се провери дали един цикъл е хамилтонов 
len([], 0).
len([H | L], N) :- len(L, Y), N is Y + 1.

hasCycle(G) :- edge(G,A,B), path(G,A,B,P), len(P, N), N > 2.
% Идеята е тук да има два върха A и B в графът между които има път който е с дължина минимум 3
% Идеята е че един граф ако има цикъл този цикъл има мимимъм дължина от 3

% Зад 8: Да се провери графът дали е свързан (само тази задача не я разбрах затова гледай да я наизустиш)

isConnected([V,E]) :- not((member(A,V), member(B,V), A\=B,not(path(G, A,B, _)))).

% Зад 9: Да се намери покриващото дърво на един граф

spanningTree([V,E], ST) :- V=[H|T], spanningTree_helper([V,E], [H], T, ST).

spanningTree_helper(_,_,[],[]).
spanningTree_helper([V,E], Visited, NotVisited, [[U, W] | ST]) :-
		member(U,Visited),
		edge([V,E], U, W),
		member(W, NotVisited),
		remove(W, NotVisited, NewNotVisited),
		spanningTree([V,E], [W | Visited], NewNotVisited, ST).