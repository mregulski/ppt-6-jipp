-module(preschool).
-export([przedszkolanka/1,send/3]).

przedszkolanka(N) ->
    spawn(fun () -> kids_loop(N) end).

send(Pid, Request, Name) ->
    Pid ! {self(), Request, Name},
    receive
        Response -> Response
    end.

kids_loop(Max) ->
    kids_loop(Max, 0).

kids_loop(Max,Current) ->
    receive
        {Who, pozostaw, Name} ->
            if
                Current >= Max -> Who ! {error, Name}, NextCurrent = Current;
                true ->
                    case get(Who) of
                        undefined -> % no kids left by this parent yet
                            put(Who, [Name]),
                            Who ! {ok, Name},
                            NextCurrent = Current + 1;
                        Names ->
                            case lists:member(Name, Names) of
                                false ->
                                    put(Who, [Name | Names]),
                                    NextCurrent = Current + 1,
                                    Who ! {ok, Name};
                                true -> % assume one parent won't have two kids by the same name
                                    NextCurrent = Current,
                                    Who ! {error, Name}
                            end
                    end
            end,
            kids_loop(Max, NextCurrent);
        {Who, odbierz, Name} ->
            case get(Who) of
                undefined -> % no kids left by this parent yet
                    Who ! {error, Name},
                    NextCurrent = Current;
                Names ->
                    case lists:member(Name, Names) of
                        true ->
                            put(Who, [Names]--[Name]),
                            NextCurrent = Current - 1,
                            Who ! {ok, Name};
                        false ->    % no child with specified name
                            NextCurrent = Current,
                            Who ! {error, Name}
                    end
            end,
            kids_loop(Max, NextCurrent);
        {Who, X, Y} ->
            Who ! {error, X, Y},
            kids_loop(Max, Current);
        Other ->
            io:format("unrecognized message ~p~n", [Other]),
            kids_loop(Max, Current)
    end.