split([], [], []).
split([H|T], [H|F], G) :- split(T, F, G).
split([H|T], F, [H|G]) :- split(T, F, G).


member(X, [X | _]).
member(X, [H | T]) :- member(X, T), X \= H.

union([], L2, L2).
union([H | T], L2, Result) :- member(H, L2), union(T, L2, Result).
union([H | T], L2, [H | Result]) :- not(member(H, L2)), union(T, L2, Result). 

isSubset([], _).
isSubset([H | T], [Y | Q]) :- isSubset([H | T], Q), H \= Y.
isSubset([H | T], [H | Q]) :- isSubset(T,Q).

p([H | T]) :- split(H, L1, L2), p_helper([H | T], T, L1, L1).
p_helper(L, [], L1, L2) :- union(L1,L2, Result), isSubset(Result, L).
p_helper(L, [H | T], L1, L2) :- split(H, T, Q), append(L1, T, R1), append(L2, Q, R2), p_helper(L, T, R1, R2).