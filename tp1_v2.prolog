% proyecto( nombre,	 cantidadProgramadores, horasEstimadas, lenguaje )
proyecto( cassandra, 1, 10, python ).
proyecto( atenea, 4, 25, html ).
proyecto( calisto, 2, 40, php ).
%proyecto( facebook, 100, 345, php ).		% hecho añadido
proyecto( twitter, 98, 212, html ).		% hecho añadido
%proyecto( codeacademy, 15, 211, javascript ).  % hecho añadido

% profesional( nombre, lenguaje ).
profesional( peter, javascript ).
profesional( ricardo, php ).
profesional( mikel, html ).
profesional( juan, html ).               	% hecho añadido
profesional( elsa, html ).		        % hecho añadido
profesional( vanda, html).	       	        % hecho añadido

% valorHora( lenguaje, valor ).
valorHora( html, 4 ).
valorHora( javascript, 6 ).
valorHora( ruby, 10 ).
%valorHora( php, 1).			        % hecho añadido

% 1) gana/2 indica cuanto gana por hora un profesional de acuerdo al lenguaje que maneja
gana(Persona, Valor) :-	
			profesional(Persona, Lenguaje),
			valorHora(Lenguaje, Valor).
gana(Persona,Valor) :-
			profesional(Persona,Lenguaje),
			not(valorHora(Lenguaje,_)),
			Valor is 0.

% 2) candidato/2 : saber quien o quienes son los candidatos para un proyecto.Para ello, el candidato debe saber el lenguaje que se requiere para el proyecto.
candidato(Proyecto, ListaCandidatos) :-
					proyecto(Proyecto,_,_,Lenguaje),
					findall(Desarrollador,profesional(Desarrollador, Lenguaje),ListaCandidatos).

% 3) candidatoRequerido/1 : quienes son los profesionales requeridos por mas de un proyecto.
 eliminarRepetidos([], []). 
 eliminarRepetidos([X], [X]). 
 eliminarRepetidos([X, X|Xs], Zs):- 
 					eliminarRepetidos([X|Xs], Zs).
 eliminarRepetidos([X, Y|Ys], [X|Zs]):- 	
 					X \= Y, 
 					eliminarRepetidos([Y|Ys], Zs).

 candidatoRequeridoBis(Persona) :- 
 				profesional(Persona,Lenguaje),
 				proyecto(NombreProyecto1,_,_,Lenguaje), 
 				proyecto(NombreProyecto2,_,_,Lenguaje), 
 				Proyecto1 \= NombreProyecto2.	

candidatoRequerido(Persona) :- 
				findall(Persona,candidatoRequeridoBis(Persona),Lista),
				eliminarRepetidos(Lista,Lista2),
				member(Persona,Lista2).
 							 
 							
					
% 4) costoProyecto/2 : valor del proyecto de acuerdo al tiempo y el costo por hora del lenguaje.
costoProyecto(Proyecto, Costo) :-
				proyecto(Proyecto,Desarrolladores,Tiempo,Lenguaje),
				valorHora(Lenguaje,Valor),
				Costo is Valor*Tiempo*Desarrolladores.

% 5) ganaMas/2 : saber si un profesional gana mas que otro
sueldo(Persona,Sueldo) :-	
			profesional(Persona,Lenguaje),
			gana(Persona,Valor),
			proyecto(_,_,Tiempo, Lenguaje),
			Sueldo is (Tiempo*Valor).
sueldo(Persona,Sueldo) :- 
			profesional(Persona,Lenguaje),
			not(proyecto(_,_,_,Lenguaje)),
			Sueldo is 0.		

ganaMas(Persona1,Persona2) :-
				sueldo(Persona1,Sueldo1),
				sueldo(Persona2,Sueldo2),
				Sueldo1 > Sueldo2.

% 6) proyectoDificil/1 : es verdadero para un proyecto, cuando no tiene ningun candidato.	
proyectoDificil(Proyecto) :- 
				candidato(Proyecto,ListaCandidatos),
				ListaCandidatos = [].
% 7) cantidadDeCandidatos/2: saber la cantidad de profesionales que saben el lenguaje para realizar un proyecto.
cantidadDeCandidatos(Proyecto,Cantidad):- 
					candidato(Proyecto,ListaCandidatos),
					length(ListaCandidatos,Cantidad).
% 8)factible/1: valida si contamos con los profesionales necesarios para realizar el proyecto.
factible(Proyecto):-
			proyecto(Proyecto,CantidadNec,_,_),
			cantidadDeCandidatos(Proyecto,Cantidad),
			CantidadNec =< Cantidad.



