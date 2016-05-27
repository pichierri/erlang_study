%%%-------------------------------------------------------------------
%%% @author pichierrif
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. mag 2016 15:54
%%%-------------------------------------------------------------------
-module(multiproc).
-author("pichierrif").
-compile(export_all).

sleep(T) ->
  receive
    after T -> ok
  end.

flush() ->
  receive
    _ -> flush()
  after 0 ->
    ok
  end.

important() ->
  receive
    {Priority, Message} when Priority > 10 ->
      [Message | important()]
  after 0 ->
    normal()
  end.

normal() ->
  receive
    {_, Message} ->
      [Message | normal()]
  after 0 ->
    []
  end.
