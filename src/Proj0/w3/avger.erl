-module(avger).

-export([averager/1]).

averager(State = {Sum, Count}) ->
  New_state =
    receive
      Num when is_number(Num) ->
        {Sum + Num, Count + 1};
      _ ->
        State
    end,
  io:format("~f~n", [element(1, New_state) / element(2, New_state)]),
  averager(New_state).
