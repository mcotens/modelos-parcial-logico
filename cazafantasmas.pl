%los cazafantasmas (Peter, Egon, Ray y Winston)

herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordeadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

%tareaPedida(tarea, cliente, metrosCuadrados).
tareaPedida(ordenarCuarto, dana, 20).
tareaPedida(cortarPasto, walter, 50).
tareaPedida(limpiarTecho, walter, 70).
tareaPedida(limpiarBanio, louis, 15).

%precio(tarea, precioPorMetroCuadrado).
precio(ordenarCuarto, 13).
precio(limpiarTecho, 20).
precio(limpiarBanio, 55).
precio(cortarPasto, 10).
precio(encerarPisos, 7).

cazafantasmas(Nombre):-
    tiene(Nombre,_).

%PUNTO 1
tiene(egon, aspiradora(200)).
tiene(egon, trapeador).
tiene(peter, trapeador).
tiene(winston, varitaDeNeutrones).

%PUNTO 2
satisfaceHerramienta(Nombre, aspiradora(Potencia)):-
    tiene(Nombre, aspiradora(PotenciaActual)),
    PotenciaActual >= Potencia.
satisfaceHerramienta(Nombre, Herramienta):-
    tiene(Nombre, Herramienta).

%PUNTO 3
hacerTarea(Persona, _):-
    tiene(Persona, varitaDeNeutrones).
hacerTarea(Persona, Tarea):-
    herramientasRequeridas(Tarea, Herramientas),
    satisfacerTodasHerramientas(Persona, Herramientas).

satisfacerTodasHerramientas(_, []).
satisfacerTodasHerramientas(Persona, [Primera | Resto]):-
    satisfaceHerramienta(Persona, Primera),
    satisfacerTodasHerramientas(Persona, Resto).

%PUNTO 4
cobrarAlCliente(Cliente, Tarea, Precio):-
    tareaPedida(Cliente, Tarea, MetrosCuadrados),
    precio(Tarea, PrecioPorMetroCuadrado),
    Precio is MetrosCuadrados * PrecioPorMetroCuadrado.

%PUNTO 5
aceptaPedido(Trabajador, Tareas):-
    cazafantasmas(Trabajador),
    puedeHacerTodas(Trabajador, Tareas),
    dispuestoAceptar(Trabajador, Tareas).

puedeHacerTodas(Trabajador, [PrimerTarea | RestoDeTareas]):-
    hacerTarea(Trabajador, PrimerTarea),
    puedeHacerTodas(Trabajador, RestoDeTareas).

dispuestoAceptar(ray, Tareas):-
    not(member(limpiarTecho, Tareas)).

dispuestoAceptar(winston, Tareas):-
   cobrarClientePorVariasTareas(winston, Tareas, Precio),
   Precio > 500.

cobrarClientePorVariasTareas(_, [], Precio).
cobrarClientePorVariasTareas(Trabajador, [PrimeraTarea | RestoDeTareas], Precio):-
    cobrarAlCliente(Trabajador,PrimerTarea,Precio2),
    Precio is Precio + Precio2,
    cobrarClientePorVariasTareas(Trabajador, RestoDeTareas, Precio).

dispuestoAceptar(egon, Tareas):-
    forall(member(Tarea, Tareas), not(esTareaCompleja(Tarea))).

esTareaCompleja(Tarea):-
    herramientasRequeridas(Tarea, Herramientas),
    length(Herramientas, Cantidad),
    Cantidad > 2.
esTareaCompleja(limpiarTecho).

dispuestoAceptar(peter, _).

%PUNTO 6
herramientasRequeridas(ordenarCuarto, [escoba, trapeador, plumero]).



    


