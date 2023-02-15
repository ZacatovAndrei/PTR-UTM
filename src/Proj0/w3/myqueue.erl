-module(myqueue).

-export([new_queue/0, push/2,pop/1,list/1]).

new_queue() ->
  spawn(fun() -> queue_actor([]) end).

queue_actor(Stack) when is_list(Stack) ->
  New_stack =
    receive
      {info} ->
        io:format("~p~n", [lists:reverse(Stack)]),
        Stack;
      {push, From, Ref, Data} ->
        From ! {Ref, ok},
        [Data | Stack];
      {pop, From, Ref} when length(Stack) > 0 ->
        [Ret | Rest] = lists:reverse(Stack),
        From ! {Ref, Ret},
        lists:reverse(Rest);
      {pop, From,Ref} ->
        From ! {Ref,{error, "Queue empty"}},
        Stack
    end,
  queue_actor(New_stack).

list(Queue_pid) when is_pid(Queue_pid)->
  Queue_pid!{info},ok.

push(Queue_pid, Data) when is_pid(Queue_pid) ->
  Ref = make_ref(),
  Queue_pid ! {push, self(), Ref, Data},
  receive
    {Ref, ok} ->
      ok
  end.

pop(Queue_pid) when is_pid(Queue_pid) ->
  Ref =make_ref(),
  Queue_pid!{pop,self(),Ref},
  receive
    {Ref,Data} ->
          Data
  end.
