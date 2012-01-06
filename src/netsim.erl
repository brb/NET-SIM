-module(netsim).
-include("include/log_utils.hrl").

-behavior(application).

-export([start_app/0]).
-export([start/2, stop/1]).

start_app() ->
    ok = application:start(sasl),
    ok = application:start(lager),
    ok = application:start(netsim),
    netsim_bootstrap:init().

start(_, _) ->
    {ok, _Pid} = netsim_sup:start_link().

stop(_State) ->
    ok.

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

integration_test_() ->
    {foreach,
        fun start_app/0,
        fun cleanup/1,
        [
            {"Yadda test", fun yadda/0}
        ]
    }.

yadda() ->
    % @todo Replace with a fully deterministic thing
    timer:sleep(1000),
    %netsim_clock_serv:sync_state(finalize),
    ok.

cleanup(_) ->
    ?mute_log(),
    application:stop(sasl),
    application:stop(netsim),
    application:stop(lager),
    ?unmute_log().

-endif.
