% Lab 3 FLP
% cum raspunde Prolog intrebarilor
% Algoritmul de unificare

% Substitutia este o functie partiala de la multimea variabilelor in multimea termenilor
% sigma : Var -> Trm(Limbaj)

% spunem ca 2 termeni T1, T2 unifica daca exista o substitutie theta
% astfel incat theta(t1) = theta(t2)

% Algoritmul de unificare

% Operatie in algoritm      Multimea solutiei        Lista de rezolvat
%                                   S                       R
%================================================================================
% Initial                       Multimea vida               t1=t1', t2=t2', ..., tn = tn'
%------------------------------------------------------------------------------------------
% SCOATE                               S                        R', t = t
%                                      S                        R'
%------------------------------------------------------------------------------------------
% DESCOMPUNE                           S                        R', f(t1,t2...,tn) = f(t1',t2', ...,tn')
%                                      S                        R', t1 = t1', t2 = t2', ...., tn = tn'
%------------------------------------------------------------------------------------------
% REZOLVA                              S                        R', x=t sau t=x astfel incat x nu apare in t
%                                      x=t, S[t/x]              R'[t/x]
%------------------------------------------------------------------------------------------
% Final                                 S                        Multimea vida
%------------------------------------------------------------------------------------------
% S este unificatorul pentru termenii dati initial in multimea(lista) de rezolvat

% Alg nu gaseste un unificator, respectiv aplica ESEC in urm situatii
% - daca incercam sa unificam simboluri de functii diferite  obtinem esec
% f(t1,t2,..,tn) = g(t1', t2',...,tn')
% constantele sunt simboluri de functii de aritate 0
% - daca avem o egalitate in lista de rezolvat de forma x=t sau t=x, dar x este variabila in t


% Exercitii  INTRA IN SESIUNE SIGUR
% simbolurile de variabile: x,y,z,u,v
% constantele: a,b,c
% functii de aritate 1: h, g, ()^(-1)
% functii de aritate 2: f, +, *
% functii de aritate 3: p


% Ex1:
% Sa se gaseasca un unificator pt termenii p(a, x, h(g(y))) si p(z, h(z), h(u)).
%Solutie:
% Lista solutiei                Lista de rezolvat                   Operatie
%       Vida               p(a, x, h(g(y))) = p(z, h(z), h(u))        DESCOMPUNERE
%       Vida               a=z, x=h(z), h(g(y))=h(u)                  DESCOMPUNERE
%       Vida               a=z, x=h(z), g(y) = u                      REZOLVA
%       z=a                x=h(a), g(y) = u                           REZOLVA
%       z=a, x=h(a)        g(y) = u                                   REZOLVA
%       z=a, x=h(a), u=g(y)         VIDA                              Final

% Am gasit unificatorul {a/z, h(a)/x, g(y)/u}       unde / inseamna 'il inlocuieste pe'



% Ex2:
% Sa se gaseasca un unificator pt termenii f(h(a), g(x)) = f(y, y).
% Solutie:
%Lista solutiei         Lista de rezolvat           Operatie
%   Vida               f(h(a), g(x)) = f(y, y)      DESCOMPUNERE
%   Vida            h(a) = y, g(x) = y              REZOLVA
% y = h(a)          g(x) = h(a)                     ESEC.
%Nu exista un unificator



%Ex3:
% Sa se gaseasca un unificator pt p(a, x, g(x)) = p(a, y, y)
% Lista solutiei                Lista de rezolvat                   Operatie
%       Vida                 p(a, x, g(x)) = p(a, y, y)             DESCOMPUNE
%       Vida                a = a, x = y, g(x) = y                  SCOATE
%       Vida                   x=y, g(x) = y                        REZOLVA
%       x=y                    g(y) = y                             ESEC
%Nu exista unificator
% SWI-Prolog imi intoarce totusi g(y) = y ala din motive de performanta, dar teoretic nu este corect.
% Pot face si aceasta verificare cu unify_with_occurs_check/2


%Ex4:
%   x + (y*y) = (y*y) + z
% +(x, *(y,y)) = +(*(y,y), z)
% Lista solutiei                Lista de rezolvat                   Operatie
%       Vida                    x + (y*y) = (y*y) + z            DESCOMPUNE
%       Vida                  x = y*y, y*y = z                  REZOLVA
%       x = y*y                 z = y*y                          Rezolva
%       x = y*y, z = y*y          Vida                          Final

%Unificatorul {y*y/x, y*y/z}

%TEMA (x*y)*z = u*(u)^(-1)

%Exercitiile de Prolog:

%Ex1 rebusul:

word(abalone,a,b,a,l,o,n,e).
word(abandon,a,b,a,n,d,o,n).
word(anagram,a,n,a,g,r,a,m).
word(connect,c,o,n,n,e,c,t).
word(elegant,e,l,e,g,a,n,t).
word(enhance,e,n,h,a,n,c,e).

crossword(V1,V2,V3,H1,H2,H3) :- 
    word(V1, _, A, _, B, _, C, _),
    word(V2, _, D, _, E, _, F, _),
    word(V3, _, G, _, H, _, I, _),
    word(H1, _, A, _, D, _, G, _),
    word(H2, _, B, _, E, _, H, _),
    word(H3, _, C, _, F, _, I, _).


%Ex2 baza de date:
% date(Day, Month, Year)

born(jan, date(20,3,1977)).
born(jeroen, date(2,2,1992)).
born(joris, date(17,3,1995)).
born(jelle, date(1,1,2004)).
born(joan, date(24,12,0)).
born(joop, date(30,4,1989)).
born(jannecke, date(17, 3, 1993)),
born(jaap, date(16,11,1995)).

year(Year, Person) :-
    born(Person, date(_,_,Year)).

before(date(D1,M1,Y1), date(D2,M2,Y2)) :-
    Y1 < Y2;
    Y1 =:= Y2, M1 < M2;
    Y1 =:= Y2, M1 =:= M2, D1 < D2.


older(X, Y) :-
    born(X, DateX),
    born(Y, DateY),
    before(DateX, DateY).


%Ex3 drumuri in lab

connected(1,2).
connected(3,4).
connected(5,6).
connected(7,8).
connected(9,10).
connected(12,13).
connected(13,14).
connected(15,16).
connected(17,18).
connected(19,20).
connected(4,1).
connected(6,3).
connected(4,7).
connected(6,11).
connected(14,9).
connected(11,15).
connected(16,12).
connected(14,17).
connected(16,19).

path(X, Y) :- connected(X, Y).
path(X,Y) :- 
    connected(X, Z),
    path(Z, Y).

% Tema solutia pt a elimina ciclurile este sa avem o lista de noduri vizitate
% path(X, Y, Vizitat)
% path(X,Y,V) :- not(member(X,V)), connected(X,Z), path(Z,Y,[X|V]) 


%Ex4 reprezentarea numerelor naturale ca lista
succesor(L, [x|L]).

plus(L1, L2, LR) :-
    append(L1, L2, LR).

times([], _, []).
times([x|T], L2, LR) :-
    times(T, L2, ListaTail),
    plus(L2, ListaTail, LR).


%ex5

element_at([H|_],0,H).
element_at([_|T],Index,Result) :-
    NewIndex is Index-1,
    element_at(T, NewIndex, Result).



%ex 6
/* Animal  database */

animal(alligator). 
animal(tortue) .
animal(caribou).
animal (ours) .
animal(cheval) .
animal(vache) .
animal(lapin) .

%folosim name()/2 care intoarce lista de ascii
% mutant/1

mutant(X) :-
    animal(Y),
    animal(Z),
    Y \= Z,
    name(Y, Ly),
    name(Z, Lz),
    append(Y1, Y2, Ly),
    append(Y2, _, Lz),
    Y2 \= [],
    append(Y1, Lz, Lx),
    name(X, Lx).