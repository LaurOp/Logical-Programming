%TEMA (x*y)*z = u*(u)^(-1)
% *(*(x,y), z) = *(u, ^(-1)(u))

% Lista solutiei                Lista de rezolvat                   Operatie
%     Vida                  *(*(x,y), z) = *(u, ^(-1)(u))           DESCOMPUNE
%     Vida                  u = *(x, y), z = u^(-1)                 REZOLVA
%     u = (x*y)                    z = (x*y)^(-1)                   REZOLVA
%     u = (x*y), z=(x*y)^(-1)           VIDA                        FINAL

% Unificatorul {x*y/u, (x*y)^(-1)/z}



% Tema solutia pt a elimina ciclurile este sa avem o lista de noduri vizitate


%path(X, Y) care merge si pe graf cu cicluri
path(X,Y) :- pathAux(X,Y,[]).
pathAux(X,Y,V) :- 
    connected(X,Z),
    not(memberchk(Z,V)),
    (
        Z = Y; 
        pathAux(Z,Y,[X|V])
    ).
    


