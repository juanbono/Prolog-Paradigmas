% jugadores conocidos 
jugador(maradona). 
jugador(chamot). 
jugador(balbo). 
 
jugador(caniggia). 
jugador(passarella). 
jugador(pedemonti). 
jugador(basualdo). 
% relaciona lo que toma cada jugador 
tomo(maradona, sustancia(efedrina)). 
tomo(maradona, compuesto(cafeVeloz)). 
tomo(caniggia, producto(cocacola, 2)). 
tomo(chamot, compuesto(cafeVeloz)). 
tomo(balbo, producto(gatoreit, 2)). 

% relaciona la máxima cantidad de un producto que 1 jugador puede ingerir 
maximo(cocacola, 3). 
maximo(gatoreit, 1). 
maximo(naranju, 5). 
 
% relaciona las sustancias que tiene un compuesto 
composicion(cafeVeloz, [efedrina, ajipupa, extasis, whisky, cafe]). 
 
% sustancias prohibidas por la asociación 
sustanciaProhibida(efedrina). 
sustanciaProhibida(cocaina). 

% 1
% a
toma(pasarella,Bebida):-
						tomo(_,Bebida),
						not( tomo(maradona,Bebida)).
% b 
tomo(pedemonti,Bebida):-
        tomo(chamot,Bebida),
        tomo(maradona,Bebida).
% c
noTomaProducto(Persona, Producto):-
							not( tomo(Persona, producto(Producto,_)) ).
noTomaProducto(basualdo, cocacola).

% 2 serSuspendido/1
puedeSerSuspendido(Jugador):-
						tomo(Jugador, sustancia(SustanciaTomada)),
						sustanciaProhibida(SustanciaTomada).

puedeSerSuspendido(Jugador):-
						tomo(Jugador, compuesto(CompuestoTomado)),
						composicion(CompuestoTomado, ListaComposicion),
						sustanciaProhibida(Sustancia),
						member(Sustancia,ListaComposicion).
puedeSerSuspendido(Jugador):-
						tomo(Jugador, producto(ProductoTomado,CantidadTomada)),
						maximo(ProductoTomado, CantidadMaxima),
						CantidadTomada >= CantidadMaxima.

amigo(maradona, caniggia). 
amigo(caniggia, balbo). 
amigo(balbo, chamot). 
amigo(balbo, pedemonti). 

malaInfluencia(Jugador1,Jugador2):-
	puedeSerSuspendido(Jugador1),
	puedeSerSuspendido(Jugador2),
	seConocen(Jugador1,Jugador2).

seConocen(Jugador1,Jugador2):-
	jugador(Jugador1),
	jugador(Jugador2),
	amigo(Jugador1,Jugador2).

seConocen(Jugador1,Amigo):-
     						amigo(Jugador1,Jugador2),
							seConocen(Jugador2,Amigo).

atiende(cahe, maradona). 
atiende(cahe, chamot). 
atiende(cahe, balbo). 
atiende(zin, caniggia). 
atiende(cureta, pedemonti). 
atiende(cureta, basualdo). 

% 4) chanta/1
chanta(Medico):-
				atiende(Medico, Jugador),
				puedeSerSuspendido(Jugador).

% 5) este no lo termine 
nivelFalopez(efedrina, 10). 
nivelFalopez(cocaina, 100). 
nivelFalopez(extasis, 120). 
nivelFalopez(omeprazol, 5). 

alteracion(Producto,Nivel):-
							tomo(_, producto(Producto,_)),
							Nivel is 0.
alteracion(Producto,Nivel):-
							tomo(_,sustancia(Producto)),
							nivelFalopez(Producto,Nivel).
% falta alteracion para compuestos	

% 6 
medicoConProblemas(Medico):-
							atiende(Medico,_),	
							findall(Jugador,atiende(Medico,Jugador),ListaAtendidos),
							length(ListaAtendidos,Cantidad),
							Cantidad >= 3.
% 7 esta mal este 
programaTVFantinesco(Lista):-
							puedeSerSuspendido(_),
							findall(Jugador,puedeSerSuspendido(Jugador),Lista),
							append(Lista,Lista,Lista).
