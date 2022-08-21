%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parte 2 - La copa de las casas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PUNTO 1 %
mago(Mago):-
    esDe(Mago, _).

acciones(harry, nocheFueraDeCama).
acciones(hermione, tercerPiso).
acciones(hermione, biblioteca).
acciones(harry, bosque).
acciones(harry, tercerPiso).
acciones(draco, mazmorras).
acciones(ron, ganarAjedrez).
acciones(hermione, salvarAmigos).
acciones(harry, ganarVoldemort).

puntaje(bosque, (-50)).
puntaje(biblioteca, (-10)).
puntaje(tercerPiso, (-75)).
puntaje(nocheFueraDeCama, (-50)).
puntaje(ganarAjedrez, 50).
puntaje(salvarAmigos, 50).
puntaje(ganarVoldemort, 60).

puntaje(Pregunta, Puntaje):-
    pregunta(Pregunta, Puntos, snape),
    Puntaje is Puntos / 2.
puntaje(Pregunta, Puntaje):-
    pregunta(Pregunta, Puntaje, Profesor),
    Profesor \= snape.

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

casa(Casa):-
    esDe(_, Casa).

% PUNTO 1 %
esBuenAlumno(Mago):-
    acciones(Mago, _),
    forall(acciones(Mago, Accion), (puntaje(Accion, Puntaje), Puntaje >=0)).

esRecurrente(Accion):-
    acciones(Mago1, Accion),
    acciones(Mago2, Accion),
    Mago1 \= Mago2.

% PUNTO 2 
puntajeCasa(Casa, Puntaje):-
    casa(Casa),
    findall(Punto, (esDe(Mago, Casa), acciones(Mago, Accion), puntaje(Accion, Punto)), Puntos),
    sum_list(Puntos, Puntaje).
    
% PUNTO 3
casaGanadora(Casa):-
    casa(Casa),
    puntajeCasa(Casa, Puntaje),
    forall((casa(OtraCasa), Casa \= OtraCasa), (puntajeCasa(OtraCasa, OtroPuntaje), Puntaje >= OtroPuntaje)).

% PUNTO 4
pregunta(dondeSeEncuentraBezoar, 20, snape).
pregunta(comoLevitarUnaPluma, 25, flitwick).

acciones(hermione, dondeSeEncuentraBezoar).  
acciones(hermione, comoLevitarUnaPluma).  