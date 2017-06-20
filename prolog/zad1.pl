arc(a,b).
arc(a,d).
arc(b,c).
arc(b,e).
arc(c,f).
arc(d,e).
arc(d,g).
arc(e,f).
arc(e,h).
arc(f,i).
arc(g,a).
arc(h,i).

path(X,X).
path(X, Y) :- path(X, Y, []).


path(X, X, _).
path(X, Y, Visited) :-
    arc(X, I),
    not(member(I, V)),
    path(I, Y, [X|Visited]).