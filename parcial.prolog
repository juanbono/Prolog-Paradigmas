% ******************************************
% * Parcial de Paradigmas de Programacion  *
% * Alumno: Juan Bono                      *
% * 2014                                   *
% ******************************************

% Hechos 
viveEn(dracula, castillo).
viveEn(godzilla, espacio).
viveEn(sullivan, espacio).
viveEn(mLegrand, tv).
viveEn(frankenstein, castillo).
viveEn(barney, tv).
viveEn(allien, espacio). 
viveEn(jesus, espacio).          % Agregado
viveEn(astronauta, espacio).     % Agregado
viveEn(gatoVolador, espacio).    % Agregado
viveEn(gea, espacio).		 % Agregado
viveEn(forever, espacio).        % Agregado
	
maneja(godzilla, auto(4)).			
maneja(barney, colectivo(fucsia,10,5)).
maneja(godzilla, auto(5)).            % Agregado 
maneja(sullivan, auto(2)).            % Agregado		
maneja(sullivan, nave([2, 3, 1])).
maneja(forever, colectivo(rojo,5,5)). % Agregado
maneja(allien, nave([3,4])).

% Puntos del Parcial
%1. estaDeAPie/1. 
estaDeAPie(Mounstruo):- not(maneja(Mounstruo, _)).	

%2. puedeLLevar/2. 
puedeLlevar(Mounstruo1, Mounstruo2):-
				viveEn(Mounstruo1, Lugar1),
				viveEn(Mounstruo2, Lugar2),
				maneja(Mounstruo1, _),
				Mounstruo1 \= Mounstruo2,
				Lugar1 = Lugar2.

%3. cantidadPasajeros/2.

% Defino el predicado cantidad que devuelve la cantidad Maxima que puede llevar un 
% vehiculo, al conductor se lo cuenta como 1. 

% caso: auto
cantidad(Mounstruo, CantidadPas):-
				maneja(Mounstruo, auto(Cantidad)),
				CantidadPas is (Cantidad-1).		
% caso: colectivo
cantidad(Mounstruo, CantidadPas):-
				maneja(Mounstruo, colectivo(_, ASimples, ADobles)),
				Cantidad is (ASimples + (ADobles*2)),
				CantidadPas is (Cantidad -1).
%caso: nave
cantidad(Mounstruo, CantidadPas):-
				maneja(Mounstruo, nave(Sectores)),
				sumlist(Sectores, Cantidad),
				CantidadPas is (Cantidad - 1).

% Defino el predicado minimo que sirve para saber el minimo entre 2 numeros
% en este caso para saber si devolver la cantidad Maxima de pasajeros que puede 
% llevar (En el caso en el que el numero de pasajeros supere el maximo) o la cantidad
% que lleva (En el caso de que el numero de pasajeros sea menor que el maximo)
minimo(Numero1, Numero2,Minimo):-
						Numero1 >= Numero2,
						Minimo is Numero2.
minimo(Numero1, Numero2,Minimo):-
						Numero1 =< Numero2,
						Minimo is Numero1 .	

cantidadPasajeros(Mounstruo,CantidadPasFinal):-
						findall(Pasajeros,puedeLlevar(Mounstruo,Pasajeros),Lista),
						length(Lista,CantidadPas),
						cantidad(Mounstruo,Cantidad),
						minimo(Cantidad,CantidadPas,CantidadPasFinal).

%4. lugarVehiculizado/1.

lugarVehiculizado(Lugar):-
			viveEn(Mounstruo,Lugar),
			forall(viveEn(Mounstruo,Lugar),maneja(Mounstruo,_)),
			forall(cantidad(Mounstruo,Cantidad),(Cantidad > 10)).
