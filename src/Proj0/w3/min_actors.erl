-module(min_actors).

-export([echoer/0, modifier/0]).

echoer() ->
  receive
    Msg ->
      io:format("~p~n", [Msg])
  end,
  echoer().

modifier() ->
  receive
    Int when is_integer(Int) ->
      io:format("~B~n", [Int + 1]);
    Str when is_binary(Str) ->
      io:format("~s~n", [string:to_lower(Str)]);
    _ ->
      io:format("I don't know how to HANDLE this!")
  end,
  modifier.
