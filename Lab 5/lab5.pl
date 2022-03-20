% Lab 5 

% Ex1
% num_aparitii/3
% num_aparitii(+List, +Elem, -NrApar).

num_aparitii([], _, 0).
num_aparitii([H|T], H, Res) :-
    num_aparitii(T, H, ResTail),
    Res is ResTail + 1.
num_aparitii([_ | T], Elem, Res) :-
    num_aparitii(T, Elem, Res).


% Ex2
% listacifre/2
% listacifre(+Nr, -List).
% listacifre(2421, List).
% List = [2,4,2,1].

listacifre_aux(X, [X]) :- X < 10.
listacifre_aux(X, [C|T]) :-
    C is X mod 10,
    D is X div 10,
    listacifre_aux(D, T).   % da la examen fara ce e mai jos drept ex 'de ce merge'

listacifre(Nr, List) :-
    listacifre_aux(Nr, ListRev),
    reverse(ListRev, List).


% Ex 3
% Lista permutarilor circulare

% listapermcirc([1,2,3], LP).
% LP = [[2,3,1], [3,1,2], [1,2,3]]

%permcirc/2
permcirc([], []).
permcirc([H|T], L) :- append(T, [H], L).

lpermcirc(L, L, [L]).
lpermcirc(L, M, [M | LP]) :-
    permcirc(M, N),
    lpermcirc(L, N, LP).

listpermcirc(L, LP) :-
    permcirc(L, M),
    lpermcirc(L, M, LP).


% Ex 4+5
elimina([], _, []).
elimina([H|T], H, R) :-
    elimina(T, H, R).
elimina([H| T], Elem, [H|R]) :-
    elimina(T, Elem, R).


multime([], []).
multime([H|T], R) :-
    member(H,T),
    multime(T, R).
multime([H|T],[H|R]) :-
    not(member(H,T)),
    multime(T,R).


emult(L) :-
    length(L, N1),
    multime(L, LM),
    length(LM, N2),
    N1 =:= N2.


intersectie([],_,[]).
intersectie([H|T], L, [H|R]) :-
    member(H, L),
    intersectie(T, L, R).
intersectie([H|T], L, R) :-
    not(member(H, L)),
    intersectie(T, L, R).



diff([],_,[]).
diff([H|T], L, [H|R]) :-
    not(member(H, L)),
    diff(T, L, R).
diff([H|T], L, R) :-
    member(H, L),
    diff(T, L, R).



element_ori_multime(_, [], []).
element_ori_multime(X, [H|T], [(X,H)|R]) :-
    element_ori_multime(X, T, R).
prod_cartezian([], _, []).
prod_cartezian([H|T], L, R) :-
    element_ori_multime(H,L,R1),
    prod_cartezian(T,L,TailResult),
    append(R1, TailResult, R).



% Ex 6

% In Prolog vom reprezenta arborii binari prin
% nil
% arb(+Radacina, + SubarbStang, + SubarbDrept).

% nil este arborele vid
% arb(ValFrunza, nil, nil) este o frunza
% arb(5, arb(4, nil, nil), arb(3, arb(2, nil, nil), arb(1, nil, arb(10,nil, nil)))).

srd(nil, []).
srd(arb(R, S, D), L) :-
    srd(S, Ls),
    srd(D, Ld),
    append(Ls, [R], LTemp),
    append(LTemp, Ld, L).

rsd(nil, []).
rsd(arb(R,S,D), L) :-
    rsd(S, Ls),
    rsd(D, Ld),
    append([R|Ls], Ld, L).

sdr(nil,[]).
sdr(arb(R,S,D), L) :-
    sdr(S, Ls),
    sdr(D, Ld),
    append(Ls,Ld,LTemp),
    append(LTemp, [R], L).


frunze(nil, []).
frunze(arb(X, nil, nil), [X]).
frunze(arb(_, S, D), L) :-
    frunze(S, Ls),
    frunze(D, Ld),
    append(Ls, Ld, L).