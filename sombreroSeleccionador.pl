%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parte 1 - Sombrero Seleccionador
% https://docs.google.com/document/d/e/2PACX-1vR9SBhz2J3lmqcMXOBs1BzSt7N1YWPoIuubAmQxPIOcnbn5Ow9REYt4NXQzOwXXiUaEQ4hfHNEt3_C7/pub
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).

caracteristicas(harry, coraje).
caracteristicas(harry, amistoso).
caracteristicas(harry, orgullo).
caracteristicas(harry, inteligencia).
caracteristicas(draco, inteligencia).
caracteristicas(draco, orgullo).
caracteristicas(hermione, inteligencia).
caracteristicas(hermione, orgullo).
caracteristicas(hermione, responsabilidad).

odiaria(harry, slytherin).
odiaria(draco, hufflepuff).

esImportante(gryffindor, coraje).
esImportante(slytherin, orgullo).
esImportante(slytherin, inteligencia).
esImportante(ravenclaw, inteligencia).
esImportante(ravenclaw, responsabilidad).
esImportante(hufflepuff, amistoso).

% PUNTO 1 %
casa(gryffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).

mago(Mago):-
    sangre(Mago, _).

permiteEntrar(Casa, Mago):-
    casa(Casa),
    mago(Mago),
    Casa \= slytherin.

permiteEntrar(slytherin, Mago):-
    sangre(Mago, Sangre),
    Sangre \= impura.

% PUNTO 2 %
tieneCaracter(Casa, Mago):-
    mago(Mago),
    casa(Casa),
    forall(esImportante(Casa, Caracteristica), caracteristicas(Mago, Caracteristica)).

% PUNTO 3 %
podriaQuedar(Casa, Mago):-
    tieneCaracter(Casa, Mago),
    permiteEntrar(Casa, Mago),
    not(odiaria(Mago, Casa)).
podriaQuedar(gryffindor, hermione).

% PUNTO 4 %
cadenaDeAmistades(Magos):-
    sonAmistosos(Magos),
    cadenaDeCasas(Magos).

sonAmistosos(Magos):-
    forall(member(Mago, Magos), caracteristicas(Mago, amistoso)).

cadenaDeCasas(Lista):-
    length(Lista, Largo),
    Largo =< 1.

cadenaDeCasas([Primero | Resto]):-
    nth1(1, Resto, Segundo),
    podriaQuedar(Casa, Primero),
    podriaQuedar(Casa, Segundo),
    Primero \= Segundo,
    cadenaDeCasas(Resto).



