-module(w2).

-export([translator/2, smallest_number/3, line_words/1, letters_combinations/1,
         group_anagrams/1, to_roman/1,greet/0]).

% string manipulation stuff

replace([{From, To} | T], String) ->
  replace(T, string:replace(String, From, To));
replace([], String) ->
  string:join(String, "").

translator(Dict, String) when is_map(Dict) ->
  Replacements = maps:to_list(Dict),
  replace(Replacements, String).

smallest_number(D1, D2, D3) when is_number(D1), is_number(D2), is_number(D3) ->
  smallest_number(lists:sort([D1, D2, D3])).

smallest_number(List = [_N1, _N2, _N3]) ->
  list_to_integer(List);
smallest_number([0, N1, N2]) ->
  list_to_integer([N1, 0, N2]);
smallest_number([0, 0, N1]) ->
  N1.

line_words(Word_list) ->
  lists:filter(fun(Word) ->
                  check_top_row(Word) orelse check_middle_row(Word) orelse check_bottom_row(Word)
               end,
               Word_list).

check_top_row([]) ->
  true;
check_top_row([Letter | Letters]) ->
  Row = "qwertyuiop",
  case lists:member(Letter, Row) of
    true ->
      check_top_row(Letters);
    _ ->
      false
  end.

check_middle_row([]) ->
  true;
check_middle_row([Letter | Letters]) ->
  Row = "asdfghjkl",
  case lists:member(Letter, Row) of
    true ->
      check_middle_row(Letters);
    false ->
      false
  end.

check_bottom_row([]) ->
  true;
check_bottom_row([Letter | Letters]) ->
  Row = "zxcvbnm",
  case lists:member(Letter, Row) of
    true ->
      check_bottom_row(Letters);
    _ ->
      false
  end.

letters_combinations([]) ->
  [[]];
letters_combinations([H | T]) when H >= $2, H =< $9 ->
  Digits =  
    #{$2 => "abc",
      $3 => "def",
      $4 => "ghi",
      $5 => "jkl",
      $6 => "mno",
      $7 => "pqrs",
      $8 => "tuv",
      $9 => "wxyz"},
  [[C | N] || C <- maps:get(H, Digits), N <- letters_combinations(T)];
letters_combinations(_List) ->
  {error, "Incorrect number"}.

group_anagrams([H | T]) ->
  Map = maps:put(H, [], #{}),
  group_anagrams(T, Map).

group_anagrams([_H | _T], Map) ->
  Map.

to_roman(Num_str) ->
  Table =
    [{1000, "M"},
     {900, "CM"},
     {500, "D"},
     {400, "CD"},
     {100, "C"},
     {90, "XC"},
     {50, "L"},
     {40, "XL"},
     {10, "X"},
     {9, "IX"},
     {5, "V"},
     {4, "IV"},
     {1, "I"}],
  {Int_num, _Rest} = string:to_integer(Num_str),
  to_roman(Int_num, Table, []).

to_roman(0, _List, Acc) ->
  lists:flatten(Acc);
to_roman(Num, List = [{A, R} | _T], Acc) when Num >= A ->
  to_roman(Num - A, List, [Acc | R]);
to_roman(Num, [{A, _R} | T], Acc) when A > Num ->
  to_roman(Num, T, Acc);
to_roman(_Num, [], _Acc) ->
  {error, "Number unparsable"}.

greet()->
  io:format("Hello PTR\n"),
  "Hello PTR".