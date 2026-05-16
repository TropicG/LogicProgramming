/* 
Трябва да се преговарят следните предикати:
- first(X, L) проверява дали X е първият елемент на L 
- second(X, L) проверява дали X е вторият елемент на L
- last(X, L) проверява дали X е последният елемент на L 
- member(X, L) проверява дали елемента X се съдържа в L 
- append(L1, L2, Result) съединява два списъка L1,L2 в Result
- remove(X, L, Result) този предикат маха само първото срещатане на X в L и генерира R.
- removeAll(X, L, Result) този предиакт премахва всички срещания на X в L и генерира R.
- insert(X, L, Result) този предикат добавя X в L, за да се получи Result
- permutation(L, Result) прави различна редица от елементите на L (пермутация) в R
- prefix(X, W) проверява дали X е префикс на W
- suffix(X, W) проверява дали X е суфикс на W
- subsequence(SubSequence, L) проверява дали subsequence е подредица на L
- subset(SubSet, L) проверява дали Subset е подмножество на L 
- reversed(L, R) прави R да бъде обърнатият списък на L
- isSorted(L) проверява дали L е сортиран списък
- pSort(L, S) проверява дали S е сортираната пермутация на L  
- minElement(L, Min) взима минималният елемент Min на L
- partition(L, L1, L2) разпределя елементите на L в списъци L1 и L2 на случаен принцип
- len(L,N) запазва в N броят на елементите на N
- nthElement(X, N, L) взима N тия елемент на списъка L в X
- nat(X) връща естествено число X
- int(X) връща цяло число X
- between(A,B,X) генерира в X всички елементи между [A,B]
- range(A,B,X) генерира в X списък всички елементи [A,B]
- pairNatural(X,Y) генерира в X,Y двойка естествени числа 
- genNS(N,S,L) генерира в L N на брой елементи с обща сума S
- isList(L) проверява дали L е списък 
- flatten(L, R) изравнява списъка L в R
- split(L,X) от всички елементи на X ги раздробява на списък от списъци в L с елементи от X
- sum(L, N) събира елементите на L в N
- tree(N, [A,B]) генерира дърво с връх N и поддървета А,B
- edge(X,Y, E) проверява дали X Y имат ребро помежду си в Е
- path(G, A, B, Path) проверява дали в G има върхове А и B с път path
- hasCycle(G) проверява дали в G има цикъл 
- isConnected(G) проверява дали G е свързан граф
- spanningTree(G, ST) генерира в ST минимално покриващото дърво на графа G
- hasCycleConnectedGraph(G) проверява дали G е свързан и има цикъл в него
*/

first(X, [X | _]).
second(X, [ _, X | _]).

last(X, [X]). 
last(X, [ H | T]) :- last(X, T), X \= H.

member(X, [X | _]). 
member(X, [H | T]) :- member(X, T), X \= H.

append([], L2, L2).
append([H | L1], L2, [H | R]) :- append(L1, L2, R).

remove(X, [X | L], L).
remove(X, [H | L], [H | R]) :- remove(X,L,R), X \= H.

removeAll(X, [], []).
removeAll(X, [X | L], R) :- removeAll(X, L, R).
removeAll(X, [H | L], [H | R]) :- removeAll(X, L, R), X \= H.

insert(X, L, R) :- remove(X, R, L).

permutation([],[]).
permutation([H | T], P) :- permutation(T, TP), insert(H, TP, P).

preffix(X,W) :- append(X,_,W).
suffix(X,W) :- append(_,X,W).

subsequence([], _).
subsequence([H | T], [X | Q]) :- subsequence([H | T], Q), H \= X.
subsequence([H | T], [H | L]) :- subsequence(T,L).

subset([], _).
subset([H | T], L) :- member(H, L), subset(T,L).

reversed([],[]).
reversed([H | T],R) :- reversed(T, RT), append(RT, [H], R).

isSorted([]).
isSorted([X]).
isSorted([X,Y | L]) :- X < Y, isSorted([Y | L]).

pSort(L,S) :- permutation(L,S), isSorted(S).

min(A,B,B) :- A > B.
min(A,B,A) :- A =< B.
minElement([H | T], Min) :- minElement(T, Tmin), min(H, Tmin, Min).

partition([],[],[]).
partition([H | L], L1, [H | L2]) :- partition(L,L1,L2).
partition([H | L], [H | L1], L2) :- partition(L,L1,L2).

len([], 0).
len([X | T], N) :- len(T, M), N is M+1.

nthElement([X | _], X, 0).
nthElement([H | L], X, N) :- nthElement(L, X, M), N is M+1.

nat(0).
nat(X) :- nat(Y), X is Y+1.

int(0).
int(1).
int(X) :- nat(Y), member(Z,[-1,1]), X is Y*Z.

between(A,B,A) :- A =< B.
between(A,B,X) :- A < B, A1 is A+1, between(A1,B,X).

range(A,B,[]) :- A > B.
range(A, B, [A | L]) :- A =< B, A1 is A+1, range(A1,B,L).

pairNatural(X,Y) :- nat(S), between(0,S,X), Y is S-X.

genNS(0,0,[]).
genNS(N,S, [H | L]) :-
    N > 0,
    between(0,S,H),
    NewS is S-H,
    NewN is N-1,
    genNS(NewN, NewS, L).

isList([]).
isList([_|_]).

flatten([],[]).
flatten([H | L], [H | F]) :- not(isList(H)), flatten(L, F).
flatten([H | L], F) :- isList(H), flatten(H, FH), flatten(T, FT), append(FH,FT,F).

split([],[]).
split(L, [ X | R]) :- append(X,Y,L), X \= [], split(Y,R).

sum([H | T], N) :- sum(T,M), N is M+H.

tree(0,[]).
tree(N, [A,B]) :- N>0, N1 is N-1, between(0,N1,P), K is N1-P, tree(P,A), tree(K,B).


edge(X,Y,E) :- member([X,Y], E), member([Y,X], E).

path([V,E], A, B, Path) :- pathHelper([V,E], A, B, [], Path).
pathHelper(_, B, B, Visited, Path) :- reversed([B | Visited], Path).
pathHelper([V,E], A, B, Visited, Path) :- A \= B, edge(A,C,E), not(member(C, Visited)), path([V,E], C, B, [A | Visited], Path).


hasCycle([V,E]) :- edge(A,B,E), A \= B, path([V,E], A, B, Path), len(Path, N), N > 2.

isConnected([V,E]) :- not((member(A,V), member(B,V), A \= B, not(path([V,E], A ,B, _)))).

spanningTree([V,E], ST) :- V=[H | T], spanningTreeHelper([V,E], [H], T, ST).
spanningTree(_,_,[],[]).
spanningTreeHelper([V,E], Visited, NonVisited, [[U,W] | ST]) :-
    member(U,Visited),
    edge(U,W,E),
    member(W, NonVisited),
    remove(W, NonVisited, NewNonVisited),
    spanningTree([V,E], Visited, NewNonVisited, ST).

hasCycleConnctedGraph([V,E]) :- isConnected([V,E]), spanningTree([V,E], ST), len(E, N), len(ST, M), N > M.
