-define(NETSIM_CLOCK, netsim_cirka).

-record('event', {
        time :: netsim_types:latency(),
        action :: add_resource | del_resource,
        nodeid :: netsim_types:nodeid(),
        resource :: netsim_types:resource()
    }).

-record(route, {
    action :: add | del,
    nodeid :: netsim_types:nodeid(), % from
    time :: netsim_types:latency(),
    routes :: [netsim_types:routes()]
}).
