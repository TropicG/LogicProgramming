/*
Зад. 11. Нека G = (V, E) е ориентиран граф. За два върха v, u ∈ V на G казваме, че u е съсед на v, ако (u, v) ∈ E е реб-ро на G.
Ще наричаме графа G k-съвършен, ако за всеки връх v ∈ V множеството от съседите на v съвпада с множеството от онези върхове u ∈ V, за които има път (незадължително прост) от v до u с дължина точно k.
Представяне на G наричаме такъв списък Edges от двуелементни списъци, че за всяко ребро (u, v) ∈ E на G списъкът [u, v] е елемент на Edges и множеството E и списъкът Edges имат един и същ брой елементи.
Да се дефинира на пролог двуместен предикат pc_Gr(Edges, K), който по дадени представяне Edges на ориентиран граф G без изолирани върхове и естествено число K > 1 разпознава дали G е K-съвършен.
*/

% Идеята е да видиш всички съседи на V който сочат към него, това множество трябва да съвпада със всички върхове от който може да се стигне до v със K стъпки
member(X, [X | _]).
member(X, [H | T]) :- member(X, T), X \= H.

edge(X,Y, E) :- member([X,Y], E).

subset([], _).
subset([H | T], L) :- member(H, L), subset(T, L).

len([], 0).
len([X | T], N) :- len(T,M), N is M+1.

append([], L2, L2).
append([H | L1], L2, [H | Result]) :- append(L1, L2, Result).

reversed([],[]).
reversed([H | L], R) :- reversed(L, LR), append(LR, [H], R).

path([V,E], A, B, Path) :- path_helper([V,E], A, B, [], Path).
path_helper(_,B,B,Visited, Path) :- reversed([B | Visited], Path).
path_helper([V,E], A, B, Visited, Path) :- A \= B, edge(A,C,E), not(visited(C, Visited)), path_helper([V,E], C, B, [A | Visited], Path).


allVertexConnected_helper(_,[],_).
% Проверяваме дали за всеки елемент от L, който беше подаден има директна връзка с Vertex 
allVertexConnected_helper([V,E], [H | T], Vertex) :- edge(H,Vertex, E), allVertexConnected([V,E], T, Vertex).
% взимаме подкрупа от върховете L и проверяваме дали тези група има директна връзка с Vertex
allVertexConnected([V,E], L, Vertex) :- subset(L, V), allVertexConnected_helper([V,E], L, Vertex).

allKPathVertex_helper(_,[],_,_).
% проверява всеки един връх от подаденият списък L дали може да достигне до Vertex с дължина K.
allKPathVertex_helper([V,E], [H | T], Vertex, K) :- path([V,E], H, Vertex, Path), len(Path, P), P =:= K. 
% взимаме подкрупа от върховете L и проверяваме дали тези върхове имат път то Vertex с дължина K 
allKPathVertex([V,E], L, Vertex, K) :- subset(L, V), allKPathVertex_helper([V,E], L, Vertex, K).


getAllVertex(Edges, Vertexes) :- getAllVertex_helper(Edges, Vertex, []).

getAllVertex_helper([[X,Y] | Edge], [X | Vertex], Visited) :-
    not(member(X, Visited)),
    getAllVertex_helper(Edge, Vertex, [ X | Visited]).


getAllVertex_helper([[Y,X] | Edge], [Y | Vertex], Visited) :-
    not(member(Y, Visited)),
    getAllVertex_helper(Edge, Vertex, [ Y | Visited]).

getAllVertex_helper([[X,Y] | Edge], [X,Y | Vertex], Visited) :-
    not(member(X, Visited)),
    not(member(Y, Visited)),
    getAllVertex_helper(Edge, Vertex, [ X,Y | Visited]).
% FIX ME, стана много късно да я довърша