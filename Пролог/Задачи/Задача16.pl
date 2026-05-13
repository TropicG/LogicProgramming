% Условието на задачата е на страница 41 от пдф файла

member(X, [X | _]).
member(X, [H | T]) :- member(X, T), X \= H.

edge(X,Y,E) :- member([X,Y], E).

path([V,E], A, B, Path) :- pathHelper()
