once(X, [X]) :- !.
once(X, [Y|T]) :- once(X, T), Y \= X.
once(X, [X|T]) :- \+ member(X, T).


twice(X, [X|T]) :- once(X, T).
twice(X, [Y|T]) :- twice(X, T), Y \= X.