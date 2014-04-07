% proyecto( nombre, cantidadProgramadores, horasEstimadas, lenguaje )
proyecto( cassandra, 1, 10, python ).
proyecto( atenea, 4, 25, html ).
proyecto( calisto, 2, 40, php ).
%proyecto( facebook, 100, 345, php ).		    % hecho añadido
%proyecto( twitter, 98, 212, html ).		    % hecho añadido
%proyecto( codeacademy, 15, 211, javascript ).      % hecho añadido

% profesional( nombre, lenguaje ).
profesional( peter, javascript ).
profesional( ricardo, php ).
profesional( mikel, html ).

% valorHora( lenguaje, valor ).
valorHora( html, 4 ).
valorHora( javascript, 6 ).
valorHora( ruby, 10 ).
valorHora( php,1).                                  % hecho añadido

% 1) gana/2 indica cuanto gana por hora un profesional de acuerdo al lenguaje que maneja
gana(Persona, Valor) :-	
			profesional(Persona, Lenguaje),
			valorHora(Lenguaje, Valor).
% 2) candidato/2 : saber quien o quienes son los candidatos para un proyecto.Para ello, el candidato debe saber el lenguaje que se requiere para el proyecto.
candidato(Proyecto, Candidatos) :-
					proyecto(Proyecto,_,_,Lenguaje),
					profesional(Candidatos, Lenguaje).

% 3) candidatoRequerido/1 : quienes son los profesionales requeridos por mas de un proyecto.
candidatoRequerido(Nombre) :-	
				profesional(Nombre, Lenguaje),
				proyecto(Proyecto,_,_,Lenguaje),
				proyecto(Proyecto2,_,_,Lenguaje),     % pequeño bug que muestra 2 veces la respuesta. Supongo que es por la propiedad simetrica del "no es igual", 
				Proyecto \= Proyecto2.		      % el programa no la tiene en cuenta y contabiliza 2 veces lo mismo. "Proyecto no es igual a Proyecto 2 y Proyecto 2 no es igual a Proyecto".
																  % Buscar solucion, en caso de ser posible.

% 4) costoProyecto/2 : valor del proyecto de acuerdo al tiempo y el costo por hora del lenguaje.
costoProyecto(Proyecto, Costo) :-
				proyecto(Proyecto,Desarrolladores,Tiempo,Lenguaje),
				valorHora(Lenguaje,Valor),
				Costo is Valor*Tiempo*Desarrolladores.

% 5) ganaMas/2 : saber si un profesional gana mas que otro
sueldo(Persona,Sueldo) :-
			profesional(Persona, Lenguaje),
			valorHora(Lenguaje, Valor),
			proyecto(_,_,Tiempo, Lenguaje),
			Sueldo is (Tiempo*Valor).
sueldo(Persona,Sueldo) :-
			not(candidato(_,Persona)),
			Sueldo is 0.

ganaMas(Persona1,Persona2) :-
			sueldo(Persona1,Sueldo1),
			sueldo(Persona2,Sueldo2),
			Sueldo1 > Sueldo2.

% 6) proyectoDificil/1 : es verdadero para un proyecto, cuando no tiene ningun candidato.
noCandidato(Proyecto) :-
			not(candidato(Proyecto,_)).
	
proyectoDificil(Proyecto) :-
			noCandidato(Proyecto).          % No funciona si el argumento se pasa como variable.
% 7) cantidadDeCandidatos/2: saber la cantidad de profesionales que saben el lenguaje para realizar un proyecto.
cantidadDeCandidatos(Proyecto,Cantidad):- 
					findall(Desarrollador,candidato(Proyecto,Desarrollador),Lista),
					length(Lista,Cantidad).
