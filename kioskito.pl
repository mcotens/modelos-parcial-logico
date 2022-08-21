:- use_module(begin_tests_con).

persona(Persona):-
    trabajador(Persona, _).

% persona(dodain).
% persona(lucas).
% persona(juanC).
% persona(juanFdS).
% persona(leoC).
% persona(martu).
% persona(vale).

% trabajador(Nombre ,horario(dia , desde, hasta))
trabajador(dodain, horario(lunes, 9, 15)).
trabajador(dodain, horario(miercoles, 9, 15)).
trabajador(dodain, horario(viernes, 9, 15)).

trabajador(lucas, horario(martes, 10, 20)).

trabajador(juanC, horario(sabado, 18, 22)).
trabajador(juanC, horario(domingo, 18, 22)).

trabajador(juanFdS, horario(jueves, 10, 20)).
trabajador(juanFdS, horario(viernes, 12, 20)).

trabajador(leoC, horario(lunes, 14, 18)).
trabajador(leoC, horario(miercoles, 14, 18)).

trabajador(martu, horario(miercoles, 23, 24)).

% -------------------------
%      PUNTO 1
% -------------------------

trabajador(vale, Horario):-
    trabajador(dodain, Horario).
trabajador(vale, Horario):-
    trabajador(juanC, Horario).

% -------------------------
%      PUNTO 2
% -------------------------

quienAtiendeElKiosko(Dia, Hora, Trabajador):-
    trabajador(Trabajador, horario(Dia, Desde, Hasta)),
    between(Desde, Hasta, Hora).

% -------------------------
%      PUNTO 3
% -------------------------
esForeverAlone(Dia,Hora,Trabajador):-
    persona(Trabajador),
    quienAtiendeElKiosko(Dia,Hora,Trabajador),
    not((quienAtiendeElKiosko(Dia,Hora,Trabajador2), Trabajador \= Trabajador2)).


% ---------------------
%      PUNTO 4
% ---------------------

podrianAtender(Dia, Personas):-
    findall(Persona, quienAtiendeElKiosko(Dia, _, Persona), Personal),
    list_to_set(Personal,Persona2),
    combinar(Persona2, Personas).

combinar([], []).
combinar([Persona|PersonasPosibles], [Persona|Personas]):-
    combinar(PersonasPosibles, Personas).
combinar([_|PersonasPosibles], Personas):-
    combinar(PersonasPosibles, Personas).


% ---------------------
%      PUNTO 5
% ---------------------

venta(dodain, fecha(lunes, 10, agosto), golosinas(1200)).
venta(dodain, fecha(lunes, 10, agosto), cigarrillos(jockey)).
venta(dodain, fecha(lunes, 10, agosto), golosinas(50)).

venta(dodain, fecha(miercoles, 12, agosto), bebidas(alcoholica, 8)).
venta(dodain, fecha(miercoles, 12, agosto), bebidas(noAlcoholica, 1)).
venta(dodain, fecha(miercoles, 12, agosto), golosinas(10)).

venta(martu, fecha(miercoles, 12, agosto), golosinas(1000)).
venta(martu, fecha(miercoles, 12, agosto), cigarrillos([chesterfield, colorado, parisiennes])).

venta(lucas, fecha(martes, 11, agosto), golosinas(600)).

venta(lucas, fecha(martes, 18, agosto), bebidas(noAlcoholica, 2)).
venta(lucas, fecha(martes, 18, agosto), cigarrillos([derby])).

esSuertuda(Persona):-
    venta(Persona, Fecha, _),
    findall(Venta, venta(Persona, Fecha, Venta), Ventas),
    esImportanteLaPrimera(Ventas).

esImportanteLaPrimera([golosinas(Precio) | _]):-
    Precio > 100.
esImportanteLaPrimera([cigarrillos(Marcas) | _]):-
    length(Marcas, Largo),
    Largo > 2.
esImportanteLaPrimera([bebidas(alcoholicas, _) | _]).
esImportanteLaPrimera([bebidas(noAlcoholicas, Cantidad) | _]):-
    Cantidad > 5.
