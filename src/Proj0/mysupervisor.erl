-module(mysupervisor).

-export([task_supervisor/1, the_task/0]).

task_supervisor(Func) when is_function(Func) ->
  process_flag(trap_exit, true),
  spawn_link(Func),
  receive
    {'EXIT', _From, normal} ->
      io:format("Task successfull~n"),
      exit(normal);
    {'EXIT', _From, Reason} ->
      io:format("Task failed because of ~w,restarting~n", [Reason]),
      spawn_link(Func);
    _other ->
      io:format("~w~n", [_other])
  end,
  task_supervisor(Func).

the_task() ->
  Num = rand:uniform(),
  if Num >= 0.5 ->
       ok;
     true ->
       exit(error)
  end.
