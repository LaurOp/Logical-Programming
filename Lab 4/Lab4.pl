%Laborator

%Doua probleme: "Zebra puzzle", "Countdown"
% Avem o strada pe care sunt 5 case, numerotate, in ordine, de la 1 la 5.
% Strada = [casa 1, casa2, casa3, casa4, casa5]
% Pentru fiecare casa avem urmatoarele caracteristici:
    % * stim numarul casei
    % * stim nationalitatea celui care locuieste
    % * stim culoarea casei
    % * stim animalul de companie
    % * stim bautura preferata
    % * stim ce tigari fumeaza

% Scop: cine este posesorul zebrei ?

% avem o serie de constrangeri

%casa(Numar, Nationalitate, Animal, Bautura, Tigari).

la_dreapta(X, Y) :- X is Y + 1.
la_stanga(X, Y) :- la_dreapta(Y, X).
langa(X, Y) :- la_stanga(X, Y) ; la_dreapta(X, Y).

solutie(PosesorZebra, Strada) :-
    Strada = [
        casa(1, _, _, _, _, _),
        casa(2, _, _, _, _, _),
        casa(3, _, _, _, _, _),
        casa(4, _, _, _, _, _),
        casa(5, _, _, _, _, _)
    ],
    member(casa(_, englez, rosie, _, _, _), Strada),
    member(casa(_, spaniol, _, caine, _, _), Strada),
    member(casa(_, _, verde, _, cafea, _), Strada),
    member(casa(_, ucrainean, _, _, ceai, _), Strada),
    member(casa(A, _, verde, _, _, _), Strada),
    member(casa(B, _, bej, _, _, _), Strada),
    la_dreapta(A, B),
    member(casa(_, _, _, melci, _, 'Old Gold'), Strada),
    member(casa(_, _, galbena, _, _, 'Kools'), Strada),
    member(casa(3, _, _, _, lapte, _), Strada),
    member(casa(1, norvegian, _,_,_,_), Strada),
    member(casa(C, _, _, _, _, 'Chesterfields'), Strada),
    member(casa(D, _, _, vulpe, _, _), Strada),
    langa(C, D),
    member(casa(E, _, _, _, _,'Kools'), Strada),
    member(casa(F,_,_,cal,_,_), Strada),
    langa(E, F),
    member(casa(_, _, _, _, sucPortocale, 'Lucky Strike'), Strada),
    member(casa(_, japonez, _, _, _, 'Parliamens'), Strada),
    member(casa(G, norvegian, _, _, _, _), Strada),
    member(casa(H, _, albastru, _, _, _), Strada),
    langa(G, H),
    member(casa(_, PosesorZebra, _, zebra, _, _), Strada).


%Countdown
%Fiind data o lista de litere, sa se gaseasca cel mai lung cuvant din limba engleza care se poate forma din literele primite.
%Nu seste necesar sa se utilizeze toate literele. Literele primite nu sunt neaparat distincte.

% word / 1
%word(hello).       sunt exemple
%word(something).

:- include('words.pl').

%Cateva predicate Prolog utile pentru acest exercitiu.

%atom_chars/2
%atom_chars(+word, -Letters).
%atom_chars primeste un cuvant si returneaza lista literelor acelui cuvant

%select/3 -- functie built in
%selet(+Elem, +List, -ListResult).
%select primeste un element, o lista, si returneaza lista din care s-a eliminat prima aparitie a lui Elem 
%de exemplu, pentru
%select(8, [1, 3, 8, 5, 8, 9], LR).
% LR = [1, 3, 5, 8, 9]

%O prima solutie ar fi sa generam toate permutarile posibile de litere, si sa verificam daca macar o varianta este un cuvant valid in limba engleza.



cover([], _).
cover([H | T], L) :-
    select(H, L, R),
    cover(T, R).

solution(ListLetters, Word, Score) :-
    word(Word),
    atom_chars(Word, Letters),
    length(Letters, Score),
    cover(Letters, ListLetters).

search_solution(_, 'no solution', 0).
search_solution(ListLetters, Word, Score) :-
    solution(ListLetters, Word, Score).
search_solution(ListLetters, Word, Score) :-
    NewScore is Score - 1,
    search_solution(ListLetters, Word, NewScore).

topsolution(ListLetters, Word) :-
    length(ListLetters, Score),
    search_solution(ListLetters, Word, Score).