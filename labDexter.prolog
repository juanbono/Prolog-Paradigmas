%actividad(personaje, actividad, lugarActividad)
%Actividades:
% inventar(nombreInvento, nivelDeAmenaza, porcentajeImpacto)
% diversion(descripcion, detalle, valoracion)
% destruir(victima)
% estudiar(listaDeTemas)

actividad(dexter, estudiar([programacion, semiotica, sistemasDeTipos,inteligenciaArtificial]),escuela).
actividad(dexter, inventar(nuevoParadigma, 90, 0.1),laboratorio).
actividad(deeDee, diversion(baile, salsa,15), playa).
actividad(deeDee, destruir(dexter),universo).
actividad(cerebro, estudiar([neorologia]), laboratorio).
actividad(cerebro, inventar(decodificadorOndasCerebrales,44,0.75),laboratorio).
actividad(cerebro, destruir(deeDee),universo).

% Los lugares que existen son los siguientes:

lugar(escuela).
lugar(laboratorio).
lugar(playa).
lugar(uqbar).
lugar(universo).

% También se tiene información de quiénes se considera genios, que pueden ser tanto
% personajes como seres reales:

genio(dexter).
genio(cerebro).
genio(einstein).

%Por último, se sabe quién admira a quién:

admira(dexter, einstein).
admira(dexter, actionHank).
admira(actionHank, monkey).


%1) Acceso a lugares
% a) Hacer el predicado tieneAcceso/2 que relaciona un personaje con un lugar al que tenga
% acceso. Debe ser inversible.
% ? Deedee tiene acceso al laboratorio.
% ? Los personajes tienen acceso a cualquier lugar en el que realizan alguna actividad
% ? Todos los personajes tienen acceso al universo.
% ? Quien estudia tiene acceso a la escuela.

tieneAcceso(Personaje,Lugar):-actividad(Personaje,_,Lugar).
tieneAcesso(Personaje,universo):-actividad(Personaje,_,_).
tieneAcceso(deeDee,laboratorio).
tieneAcceso(Personaje,escuela):- actividad(Personaje,estudiar(_),_).


% b) ¿De qué manera se puede averiguar algún lugar inaccesible?
inaccesible(Lugar):- 
			lugar(Lugar),
			not(tieneAcceso(_,Lugar)).

% 2) Inventores
% Hacer el predicado inventorCreido/1 que permite deducir si un inventor es creído. Lo es
% cuando inventa algo y solo admira a genios.

inventorCreido(Personaje) :-
			actividad(Personaje,inventar(_,_,_),_),
			forall(admira(Personaje,Idolo),genio(Idolo)).



%3) Respeto
%Hacer el predicado leDebeRespeto/2 que relaciona a dos individuos, donde el primero
%respeta al segundo. Alguien le debe respeto a quien admira y a quien éste respeta.

leDebeRespeto(Personaje,PersonajeRespetado):-admira(Personaje,PersonajeRespetado).
leDebeRespeto(Personaje,PR):-admira(Personaje,PersonajeRespetado),leDebeRespeto(PersonajeRespetado,PR).

%4) Amenazas
%a) Hacer un predicado llamado nivelDeAmenaza/2 que relaciona a un personaje con su nivel
%de amenaza. El nivel de amenaza es la sumatoria de los niveles de cada actividad que el
%personaje realiza, que se calcula de la siguiente manera:
%? estudios: 10 unidades por cada tema que estudie
%? inventos: el nivel de amenaza del invento con el porcentaje de impacto.
%? destrucción: el nivel de amenaza de la víctima
%? diversión: la valoración de la actividad

amenaza(Personaje,Nivel):-
			actividad(Personaje,estudiar(L),_),
			length(L,CantidadMaterias),
			Nivel is 10*CantidadMaterias.

amenaza(Personaje,Nivel):-
			  actividad(Personaje,inventar(_,Impacto,Porcentaje),_),
			  Nivel is Impacto*Porcentaje.

amenaza(Personaje,Nivel):-
			actividad(Personaje,destruir(Victima),_),
			amenaza(Victima,Nivel).

amenaza(Personaje,Nivel):-
			actividad(Personaje,diversion(_,_,Valoracion),_),
			Nivel is Valoracion.

nivelAmenaza(Personaje,Sumatoria):-
				findall(Nivel,amenaza(Personaje,Nivel),L),
				sumlist(L,Sumatoria).
