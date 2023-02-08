-include_lib("eunit/include/eunit.hrl").

-module(w2_test).

reverse_test() ->
  [] = mylists:reverse([]),
  [1, 2, 3] = mylists:reverse([3, 2, 1]),
  [1] = mylists:reverse([1]).

unique_sum_test() ->
  ?assert(mylists:unique_sum([]) == 0).

translator_test() ->
  Map = #{"mama" => "mother", "papa" => "father"},
  String = "mama lives with papa",
  ?assert(w2:translator(Map, String) =:= "mother lives with father").

dedup_test() ->
  [] = mylists:dedup([]),
  [1] = mylists:dedup([1]),
  [1, 2, 3] = mylists:dedup([1, 1, 1, 1, 2, 2, 3, 3]),
  [1, 2, 3, 1] = mylists:dedup([1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 1, 1, 1]).
