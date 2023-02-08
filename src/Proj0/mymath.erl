-module(mymath).

-export([check_for_prime/3, cylinder_area/2, get_fibs/1, is_prime/1,
         list_right_angle_triangles/1]).

list_right_angle_triangles(Tuple_list) when is_list(Tuple_list) ->
    lists:filter(fun(X) -> is_right_angle(X) end, Tuple_list).

is_right_angle({A, B, C}) ->
    if A * A + B * B == C * C ->
           true;
       true ->
           false
    end.

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
