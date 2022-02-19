female(mary).
female(sandra).
female(juliet).
female(lisa).
male(peter).
male(paul).
male(dony).
male(bob).
male(harry).
parent(bob, lisa).
parent(bob, paul).
parent(bob, mary).
parent(juliet, lisa).
parent(juliet, paul).
parent(juliet, mary).
parent(peter, harry).
parent(lisa, harry).
parent(mary, dony).
parent(mary, sandra).

father_of(Father, Child) :- parent(Father, Child), male(Father).

mother_of(Mother, Child) :- parent(Mother, Child), female(Mother).

grandfather_of(Grandfather, Child) :- parent(Grandfather, X), parent(X, Child), male(Grandfather).

grandmother_of(Grandmother, Child) :- parent(Grandmother, X), parent(X, Child), female(Grandmother).

sister_of(Sister, Person) :- parent(X, Person), parent(X, Sister), female(Sister), Sister \= Person.

brother_of(Brother, Person) :- parent(X, Person), parent(X, Brother), male(Brother), Brother \= Person.

aunt_of(Aunt, Person) :- sister_of(Aunt, X), parent(X, Person).

uncle_of(Uncle, Person) :- brother_of(Uncle, X), parent(X, Person).