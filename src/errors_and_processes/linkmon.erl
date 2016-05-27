-module(linkmon).
-author("Paolo Laurenti").
-export([myproc/0, chain/1, chain1/1]).

myproc() ->
  timer:sleep(5000),
  exit(reason).

chain(0) ->
  receive
    _ -> ok
  after 2000 ->
    exit("chain dies here")
  end;
chain(N) ->
  Pid = spawn(fun() -> chain(N - 1) end),
  link(Pid),
  receive
    _ -> ok
  end.


chain1(0) ->
  receive
    _ -> ok
  after 2000 ->
    exit("chain dies here")
  end;
chain1(N) ->
  spawn_link(fun() -> chain(N - 1) end),
  receive
    _ -> ok
  end.