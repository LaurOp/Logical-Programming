fib(0,1).
fib(1,1).
fib(N, Res) :- 
 	N1 is N-1,
 	N2 is N-2,
	fib(N1, Res1),
 	fib(N2, Res2),
	Res is Res1 + Res2.
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


squareAux(N, N, N, C) :-
	write(C).

squareAux(N, I, N, C) :-
	write(C),
	nl,
	I1 is I + 1,
	squareAux(N, I1, 1, C).
	

squareAux(N, I, J, C) :-
	write(C),
	J1 is J+1,
	squareAux(N, I, J1, C).

square(N, C) :-
	squareAux(N, 1, 1, C).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



element_of(H, [H|_]).
element_of(H, [_|T]) :-
	element_of(H, T).
	


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



concat_lists([], L, L).
concat_lists([Elem|L1], L2, [Elem | L3]) :- concat_lists(L1, L2, L3).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


all_a([a]).
all_a([a | T]) :- all_a(T).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


trans_a_b([a], [b]).
trans_a_b([a|T1], [b|T2]) :- trans_a_b(T1,T2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


scalarMult(_, [], []).
scalarMult(Scalar, [HI | TI], [HO | TO]) :-
	HO is Scalar * HI,
	scalarMult(Scalar, TI, TO).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dot([], [], 0).
dot([H1|T1], [H2|T2], Res) :-
	dot(T1, T2, ResTail),
	Res is ResTail + H1*H2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


max([], 0).
max([X], X).
max([H | T], Max) :-
	max(T, TailMax),
	H > TailMax,
	Max = H.
max([H | T], Max) :-
	max(T, TailMax),
	H =< TailMax,
	Max = TailMax.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% o varianta: palindrome(X) :- reverse(X, X).

reverse_of([], L, L).
reverse_of([H|T], ListTemp, ListRes) :- 
	reverse_of(T, [H|ListTemp], ListRes).

reverse_of(L, LR) :-
	reverse_of(L, [], LR).

palindrome_of(X) :- reverse_of(X, X).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

remove_duplicates([], []).
remove_duplicates([H|T],Res) :-
	member(H,T),
	remove_duplicates(T, Res).
remove_duplicates([H|T], [H|TailRes]) :-
	not(member(H,T)),
	remove_duplicates(T, TailRes).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


