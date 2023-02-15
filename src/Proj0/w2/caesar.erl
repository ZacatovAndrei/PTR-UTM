-module(caesar).

-export([encode/2, decode/2]).

encode([Letter | Rest], Shift) when Letter >= $a, Letter =< $z ->
    Adjusted_Shift = Shift rem 26 + 26,
    [$a + (Letter - $a + Adjusted_Shift) rem 26 | encode(Rest, Adjusted_Shift)];
encode([Letter | Rest], Shift) ->
    Adjusted_Shift = Shift rem 26 + 26,
    [Letter | encode(Rest, Adjusted_Shift)];
encode([], _Shift) ->
    [].

decode([Letter | Rest], Shift) when Letter >= $a, Letter =< $z ->
    Adjusted_Shift = Shift rem 26 + 26,
    [$a + (Letter - $a - Adjusted_Shift) rem 26 | decode(Rest, Adjusted_Shift)];
decode([Letter | Rest], Shift) ->
    Adjusted_Shift = Shift rem 26 + 26,
    [Letter | decode(Rest, Adjusted_Shift)];
decode([], _Shift) ->
    [].
