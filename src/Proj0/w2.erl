-module(w2).

-export([is_prime/1, cylinder_area/2, reverse/1, get_fibs/1, unique_sum/1,
         extract_random_n/2, translator/2, smallest_number/3]).

%lists stuff

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

% unrelated math stuff
cylinder_area(Height, Radius) when is_number(Height), is_number(Radius) ->
  2 * math:pi() * Radius * (Radius + Height).

get_fibs(Num) when is_integer(Num) ->
  get_fibs(0, 1, Num - 1, [1]).

get_fibs(T1, T2, 0, List) ->
  lists:reverse([T1 + T2 | List]);
get_fibs(T1, T2, Amount, List) ->
  NewNum = T1 + T2,
  get_fibs(T2, NewNum, Amount - 1, [NewNum | List]).

is_prime(2) ->
  false;
is_prime(3) ->
  true;
is_prime(Num) when Num > 3, Num rem 6 =:= 1; Num rem 6 =:= 5 ->
  check_for_prime(Num, 3, trunc(math:sqrt(Num)));
is_prime(Num) when is_number(Num) ->
  false.

check_for_prime(Num, _Div, Lim) when Num > Lim ->
  true;
check_for_prime(Num, Div, _Lim) when Num rem Div =:= 0 ->
  false;
check_for_prime(Num, Div, Lim) when is_number(Num), Lim > Num ->
  check_for_prime(Num, Div + 2, Lim).

% string manipulation stuff

replace([{From, To} | T], String) ->
  replace(T, string:replace(String, From, To));
replace([], String) ->
  string:join(String, "").

translator(Dict, String) when is_map(Dict) ->
  Replacements = maps:to_list(Dict),
  replace(Replacements, String).

%other tasks

smallest_number(D1, D2, D3) when is_number(D1), is_number(D2), is_number(D3) ->
  smallest_number(lists:sort([D1, D2, D3])).

smallest_number(List = [_N1, _N2, _N3]) ->
    list_to_integer(List);
  smallest_number([0, N1, N2]) ->
    list_to_integer([N1, 0, N2]);
  smallest_number([0, 0, N1]) ->
    N1.

