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
