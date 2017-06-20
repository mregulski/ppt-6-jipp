-module(rotation).
-export([left_rotation/1]).
left_rotation(X) ->
    case X of
        {node, K0,V0, L, {node, KR, VR, LR, RR}} -> {node, KR, VR, {node, K0, V0, L, LR}, RR};
    _Else -> error
    end.