-module(pythag).
-export([pythag/1, pythag2/1]).

pythag(N) ->
    [{A,B,N-A-B} ||
        A <- lists:seq(1,N div 3),
        B <- lists:seq(A,N div 3),
        A =< B,  % symmetry
        A*A + B*B =:= (N-A-B)*(N-A-B)
    ].
pythag2(S) ->
    [{M*M - N*N, 2*M*N, M*M + N*N } ||
       M <- lists:seq(1,S div 2),
       N <- lists:seq(1,M),
       M * (M+N) =:= S div 2
    ].