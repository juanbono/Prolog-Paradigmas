%%%Agentes%%%
% Espias %
agente(sloane, espia([ingles, frances, italiano])).
% Francotirador %
agente(vaughn, francotirador(150)). 
% Tira Bombas %
agente(bristow, tirabombas(26)). 
agente(irina,  tirabombas(4)). 
% Ninjas %
agente(guillermo, ninja(judo, [estrellita,nunchaku])). 
agente(emilio, ninja(karate, [sai])).

%%% Misiones %%%
mision(unViolinistaEnElTejado, 2, asesinato). 
mision(expresoDeOriente, 4, volarTren). 
mision(extermineitors, 2, exterminio). 

%%% Requisitos %%%
requisito(asesinato, sigilo). 
requisito(asesinato, distancia(100)). /*francotirador*/ 
requisito(volarTren, explosivos(11)). /*cant. de bombas*/ 
requisito(volarTren, idioma(italiano)). /*espía*/ 
requisito(volarTren, fuerza). 
requisito(exterminio, fuerza). 
requisito(exterminio, sigilo). 

%esCLASE
esNinja(Nombre):- agente(Nombre, ninja(_,_)).
esEspia(Nombre):- agente(Nombre, espia(_)).
esTiraBombas(Nombre):- agente(Nombre, tirabombas(_)).
esFrancotirador(Nombre):- agente(Nombre, francotirador(_)).


% cumpleRequisito/2
cumpleRequisito(explosivos(X),Nombre):-
					agente(Nombre, tirabombas(Y)),
					Y >= X.

cumpleRequisito(Idioma,Nombre):-
				agente(Nombre, espia(Lenguajes)),
				member(Idioma,Lenguajes).

cumpleRequisito(distancia(X), Nombre):-
					agente(Nombre, francotirador(Y)),
					Y >= X.

cumpleRequisito(sigilo,Nombre):-  esNinja(Nombre).
cumpleRequisito(sigilo,Nombre):-  esEspia(Nombre).
cumpleRequisito(fuerza,Nombre):-  esTiraBombas(Nombre).
cumpleRequisito(fuerza,Nombre):-  esNinja(Nombre).

% esUtil/2 Nota: Repite las respuestas, si cumplen mas de 1 condicion.
esUtil(Mision,Nombre):-
			mision(Mision,_,Objetivo),
			requisito(Objetivo,Requisito),
			cumpleRequisito(Requisito,Nombre).

%esIndispensable/2
% Con Listas Auxiliares

% Sin Listas Auxiliares

%rambo/1
rambo(Nombre):-
		agente(Nombre,_),
		forall(mision(Mision,_,_),esUtil(Mision,Nombre)).
%equipoPosible/2 Nota: me parece que en este los equipos deben ser dependiendo de la cantidad que dice la mision y no mas. 
equipoPosible(Mision,Equipo):-
				mision(Mision,CantidadRequerida,_),
				findall(Agente,esUtil(Mision,Agente),Equipo),
				length(Equipo,Cantidad),
				Cantidad >= CantidadRequerida.
%eshImposhible/1
eshImposhible(Mision):-
			mision(Mision,_,_),
			not(equipoPosible(Mision,_)).
%estoEstaLlenoDeNinjas/1
estoEstaLlenoDeNinjas(Mision):-
				mision(Mision,_,_),
				equipoPosible(Mision,Equipo),
				forall(member(Miembro,Equipo),esNinja(Miembro)).
