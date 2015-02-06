-module(quoter).

-export([start/0, start_webserver/0]).
-export([init/3, handle/2, terminate/3]).


start() ->
    application:ensure_all_started(?MODULE).


start_webserver() ->
    Dispatch = cowboy_router:compile([
                    %% {HostMatch, list({PathMatch, Handler, Opts})}
                    {'_', [{"/admin_says/:subject/cannot/:cannot/[:feature]", ?MODULE, [{renderer, admin_says_dtl}]}]}
                ]),
    %% Name, NbAcceptors, TransOpts, ProtoOpts
    cowboy:start_http(quoter_listener, 100,
                          [{ip, {0,0,0,0,0,0,0,0}}, {port, 3880}],
                          [{env, [{dispatch, Dispatch}]}]
                     ).



init(_, Req, Opts) ->
    {ok, Req, Opts}.

handle(Req, Opts) ->
    Renderer = proplists:get_value(renderer, Opts),
    true = (Renderer /= undefined),
    {AllBindings, Req1} = cowboy_req:bindings(Req),
    {ok, Body} = Renderer:render(AllBindings),
    {ok, Req2} = cowboy_req:reply(200, [{<<"content-type">>, <<"text/html">>}], Body, Req1),
    {ok, Req2, Opts}.


terminate(_, _, _) ->
    ok.
