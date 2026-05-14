% Зад. 7: Да се дефинира на Пролог предикат
% slice(L, Begin, End, N, S), който по даден списък L и три
% положителни цели числа Begin, End и N генерира в S списъка
% на всички елементи на L, които са с номера, делящи се на N и
% са между Begin и End.

% Този предикат генерира [1,2,3,4,5] индексите за елементи, ако примерно имаме подаден списък от [a,b,c,c,d,a].
generateIndexes([], [], _).
generateIndexes([H | T], [N | Q], N) :- NextIndex is N+1, generateIndexes(T,Q,NextIndex).


% Чак когато вече стигнем края просто приключваме
insertAllIndexes(_, _, End, _, End, _, _).

% Ако сме в range-a, но N не дели сегашният индекс, тогава нищо не се добавя в S
% Но продължаваме с индекса напред 
insertAllIndexes([H | L], [Index | Q], CurrentIndex, Begin, End, N, S) :-
    CurrentIndex >= Begin,
    CurrentIndex =< End,
    Index mod N =/= 0,
    NextIndex is CurrentIndex+1,
    insertAllIndexes(L, Q, NextIndex, Begin, End, N, S).

% Когато сме вече в range-a за добавяне, проверяваме дали сегашният индекс се дели на N, 
% ако се дели се подава в S и се инкрементира индекса
insertAllIndexes([H | L], [Index | Q], CurrentIndex, Begin, End, N, [H | S]) :-
    CurrentIndex >= Begin,
    CurrentIndex =< End,
    Index mod N =:= 0,
    NextIndex is CurrentIndex+1,
    insertAllIndexes(L, Q, NextIndex, Begin, End, N, S).

% Минаваме през елементите и техните индекси ([H | L], [Index | Indexes]) като инкрементираме 
% индекса, обаче все още не можем да поставяме в S, защото сегашният индекс не е стигнал до Begin
insertAllIndexes([H | L], [Index | Indexes], CurrentIndex, Begin, End, N, S) :-
    CurrentIndex < Begin,
    NextIndex is CurrentIndex+1,
    insertAllIndexes(L, Indexes, NextIndex, Begin, End, N, S).

len([], 0).
len([X | T], N) :- len(T, Y), N is Y+1.

% Добави проверка за правилни индекси
slice(L, Begin, End, N, S) :- 
    Begin >= 1,
    End >= 1,
    N >= 1,
    Begin =< End,
    generateIndexes(L, Indexes, 1),
    len(Indexes, NumIndexes),
    NumIndexes >= BeginIndex,
    NumIndexes =< End,
    insertAllIndexes(L, Indexes, 1, Begin, End, N, S).
