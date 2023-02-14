-module(mysemaphore).

-export([create_semaphore/1, acquire/1, release/1,semaphore/1]).

create_semaphore(N) when N > 0 ->
  spawn(mysemaphore,semaphore,[N]).

semaphore(0) ->
  receive
    release ->
      semaphore(1)
  end;

semaphore(N) when N > 0 ->
  receive
    {acquire, From} ->
      From ! {granted},
      semaphore(N - 1);
    release ->
      semaphore(N + 1)
  end.

acquire(Semaphore) ->
  Semaphore ! {acquire, self()},
  receive
    granted ->
      ok
  end.

release(Semaphore) ->
  Semaphore ! release.

