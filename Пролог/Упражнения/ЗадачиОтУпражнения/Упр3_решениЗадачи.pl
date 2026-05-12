% Зад 1: Да се обърне листа L и да се запази в Reversed
append([], L2, L2).
append([H | L1], L2, [H | Result]) :- append(L1, L2, Result).

reverse([], []).
reverse([H | L], Reversed) :- reverse(L, LR), append(LR, [H], Reversed).
% Опашката на L масива се обръща и се запазва в LR и към нея се добавя главата H като лист, за да получим reversed 

% Зад 2: Да се провери дали L1 и L2 са палиндром
palindrome(L1, L2) :- reverse(L2, L1).
% L2 е палиндром на L1, ако този лист се обърне и същия като L1, именно затова използваме reverse, за да докажем че L2 обърнато е точно L1

% Зад 3: Да се сортира листа L в лист S, като се използва permutation sort
remove(X, [X | T], T).
remove(X, [H | T], [H | Q]) :- remove(X, T, Q).

insert(X, L, R) :- remove(X, R, L).

permutation([], []).
permutation([H | T], PS) :- permutation(T, TP), insert(H, TP, PS).

lessOrEqual(X,Y) :- X =< Y.
isSorted([]).
isSorted([_]).
isSorted([X,Y | L]) :- lessOrEqual(X,Y), isSorted([Y | L]).

pSort(L,S) :- permutation(L,S), isSorted(S).
% Несортирания лист L, трябва да е пермутация на S и S да е сортиран
% Това е вярно защото сортирания лист е реално пермутация на несортиран лист, просто е подредена правилно

% Зад 4: Намиране на най-малък елемент в лист L
min(A,B,A) :- A =< B.
min(A,B,B) :- A > B.

minElement([X], X).
minElement([H | L], Min) :- minElement(L, MinL), min(H, MinL, Min). 
% Взимаме най-малкия елемент от опашката на L, Който да бъде MinL, след това трябва мин елемента между H и MinL да бъде Min

% Зад 5: Разделяне на един лист L в два отделни листа L1 и L2
split([], [], []).
split([X], [X], []).
split([X,Y | L], [X | L1], [Y | L2]) :- split(L, L1, L2).
% Взимат се два елемента X,Y от главата L, като единият елемент X се добавя в L1, а другия Y се добавя в L2.

% Зад 6: Merge-ване на два сортирани листа L1 и L2 в един по-голям LS (сортиран лист)
merge(LS, [], LS).
merge([], LS, LS).
merge([X | L1], [Y | L2], [X | LS]) :- X =< Y, merge(L1, [Y | L2], LS).
merge([X | L1], [Y | L2], [Y | LS]) :-  X > Y, merge([X | L1], L2, LS). 
% Взимаме главите (X,Y) на два листа L1,L2 след това проверява, ако X > Y добавя X към сортирания лист LS, в противен случай добавя Y и предава листа нататък 

% Зад 7: Да се омплементира mergeSort на листа L и резултата да се запази в LS (сортиран лист)
merge(L, S) :- L \= [], L \= [_], split(L, L1, L2), mergeSort(L1, LS1), mergeSort(L2, LS2), merge(LS1, LS2, LS).
% L трябва да е различен от [] или да има само един елемент в него, след това се разделя L на два листа L1 и L2 
% След това прави mergeSort L1 в LS1 и L2 в LS2, след това понеже са сортирани ги добавя в един по-общ в LS.