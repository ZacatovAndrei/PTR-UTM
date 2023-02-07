-include_lib("eunit/include/eunit.hrl").
-module(w2_test).

reverse_test() -> []=w2:reverse([]);
reverse_test() -> [1,2,3] = w2:reverse([3,2,1]);
reverse_test() -> [1] = w2:reverse([1]).


unique_sum_test() -> ?assert( w2:unique_sum([]) == 0).



translator_test() -> 
  Map=#{"mama"=>"mother","papa"=>"father"},
  String="mama lives with papa",
  ?assert(w2:translator(Map, String)=:="mother lives with father").
