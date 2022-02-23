replace([], _, _, []).
replace([H|T], H, C2, [C2|LR]) :-
	replace(T, H, C2, LR).
replace([H|T], C1, C2, [H|LR]) :-
	replace(T, C1, C2, LR).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fiboAux(0,[1]).
fiboAux(1,[1,1]).
fiboAux(N, [A, B, C| D]) :-
	N > 1,
	N1 is N - 1,
	fiboAux(N1, [B, C | D]),
	A is B + C.

fibo(0,1).
fibo(1,1).
fibo(N, Res) :- 
	fiboAux(N, [H|_]),
	Res is H.

