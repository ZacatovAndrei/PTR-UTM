-module(mylists).

-export([dedup/1, reverse/1, unique_sum/1, extract_random_n/2, rotate_left/2]).

dedup([]) ->
    [];
dedup([E]) ->
    [E];
dedup([H, H | T]) ->
    dedup([H | T]);
dedup([H, N | T]) when H =/= N ->
    [H | dedup([N | T])].

reverse(List) when is_list(List) ->
    reverse(List, []).

reverse(OldList = [H | T], NewList) when is_list(OldList), is_list(NewList) ->
    reverse(T, [H | NewList]);
reverse([], NewList) when is_list(NewList) ->
    NewList.

unique_sum(List) when is_list(List) ->
    lists:sum(
        lists:uniq(List)).

extract_random_n(List, Num) when is_list(List), length(List) >= Num, Num > 0 ->
    extract_random_n(List, Num, length(List), []).

extract_random_n(List, Num, Len, Acc) when Num > 0 ->
    Elem =
        lists:nth(
            rand:uniform(Len), List),
    extract_random_n(List, Num - 1, Len, [Elem | Acc]);
extract_random_n(_List, 0, _Len, Acc) ->
    Acc.

rotate_left(List, Num) when is_list(List), Num >= 0 ->
    NewNum = Num rem length(List),
    rotate_left(List, NewNum, []).

rotate_left([H | T], Num, Acc) when Num > 0 ->
    rotate_left(T, Num - 1, [H | Acc]);
rotate_left(List, 0, Acc) ->
    lists:append(List, lists:reverse(Acc)).
