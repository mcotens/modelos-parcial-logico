vocaloid(Nombre):-
    canta(Nombre, _).
vocaloid(kaito).

canta(megurineLuka, cancion(nightFever, 4)).
canta(megurineLuka, cancion(foreverYoung, 5)).
canta(hatsuneMiku, cancion(tellYourWorld, 4)).
canta(gumi, cancion(foreverYoung, 4)).
canta(gumi, cancion(tellYourWorld, 5)).
canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nightFever, 5)).

esNovedoso(Vocaloid):-
    cantaCanciones(Vocaloid, Cantidad),
    Cantidad > 1,
    tiempoTotal(Vocaloid, CantidadTiempo),
    CantidadTiempo < 15.

cantaCanciones(Vocaloid, Cantidad):-
    vocaloid(Vocaloid),
    findall(Cancion, canta(Vocaloid, Cancion), Canciones),
    length(Canciones, Cantidad).

tiempoTotal(Vocaloid, Cantidad):-
    findall(Tiempo, canta(Vocaloid, cancion(_,Tiempo)), Tiempos),
    sumlist(Tiempos, Cantidad).

esAcelerado(Vocaloid):-
    vocaloid(Vocaloid),
    findall(Tiempo, canta(Vocaloid, cancion(_, Tiempo)), Tiempos),
    max_member(TiempoMaximo, Tiempos),
    TiempoMaximo =< 4.
    
concierto(mikuExpo, estadosUnidos, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, estadosUnidos, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequeno(4)).

puedeParticiar(_, hatsuneMiku).
puedeParticiar(Concierto, Vocaloid):-  
    vocaloid(Vocaloid),  
    concierto(Concierto, _, _, gigante(Minimo, DuracionTotal)),
    cantaCanciones(Vocaloid, Cantidad),
    Cantidad >= Minimo,
    tiempoTotal(Vocaloid, TiempoTotal),
    TiempoTotal >= DuracionTotal.

puedeParticiar(Concierto, Vocaloid):-  
    vocaloid(Vocaloid),  
    concierto(Concierto, _, _, mediano(DuracionTotal)),
    tiempoTotal(Vocaloid, TiempoTotal),
    TiempoTotal < DuracionTotal.

puedeParticiar(Concierto, Vocaloid):-  
    vocaloid(Vocaloid),  
    concierto(Concierto, _, _, pequeno(Duracion)),
    canta(Vocaloid, cancion(_, TiempoCancion)),
    TiempoCancion > Duracion.

masFamoso(Vocaloid):-
    nivelDeFama(Vocaloid, Cantidad),
    forall((nivelDeFama(OtroVocaloid, OtraCantidad), OtroVocaloid \= Vocaloid), OtraCantidad < Cantidad).
    
nivelDeFama(Vocaloid, Fama):-
    famaDeConciertos(Vocaloid, FamaConciertos),
    cantaCanciones(Vocaloid, CantidadCanciones),
    Fama is FamaConciertos * CantidadCanciones.

famaDeConciertos(Vocaloid,FamaConciertos):-
    findall(Fama, (puedeParticiar(Concierto, Vocaloid), concierto(Concierto, _, Fama, _)), Famas),
    sumlist(Famas, FamaConciertos).

conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).

unicoParticipanteEntreConocidos(Cantante,Concierto):- 
    puedeParticiar(Concierto, Cantante),
	not((conocido(Cantante, OtroCantante), 
    puedeParticiar(Concierto, OtroCantante))).

%Conocido directo
conocido(Cantante, OtroCantante) :- 
conoce(Cantante, OtroCantante).

%Conocido indirecto
conocido(Cantante, OtroCantante) :- 
conoce(Cantante, UnCantante), 
conocido(UnCantante, OtroCantante).