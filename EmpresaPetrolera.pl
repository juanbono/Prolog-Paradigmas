%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ejercicio : Petrolera %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%
%% Hechos %%
%%%%%%%%%%%%

% Los productos base y el stock en cada tanque es el siguiente:
productoBase(extra,[200000,300000,500000]).
productoBase(ecologica,[400000]).
productoBase(goil,[100000,500000]).
productoBase(ulsd,[600000,500000]).
productoBase(diesel500,[950000,1000000]).
productoBase(e100,[50000,90000]).
productoBase(b100,[1000000]).

% El porcentaje aplicado en cada caso son:
porcentaje(e100,0.10).
porcentaje(b100,0.05).

% El producto comercial con su precio y componentes:
producto(go500,9.5,diesel500,b100).
producto(e8000,12,ecologica,e100).
producto(e5000,10,extra,e100).
producto(euro,11,ulsd,b100).
producto(go1500,9,goil,b100).

% Clientes, con un monton maximo de pesos permitidos y los productos habilitados para comprar:
cliente(buquebus,20000,[go500,e5000,e8000]).
cliente(petrobras,15000,[go500,e5000,e8000,euro]).
cliente(oronegro,5000,[go500,go1500]).

%%%%%%%%%%%%%%%%%%
%% Se solicita: %%
%%%%%%%%%%%%%%%%%%

%1) Calcular el costo de un pedido, ingresando la cantidad solicitada y el nombre comercial.
costo(Producto,Cantidad,Total):-
	producto(Producto,Precio,_,_),
	Total is Cantidad*Precio.

%2) Calcular el stock actual de un producto base.
suma(Producto,Total):-
	productoBase(Producto,Lista),
	sumlist(Lista,Total).

%3) Verificar si un determinado cliente puede cargar cierto producto.
verificar(Cliente,Producto):-
	cliente(Cliente,_,Lista),
	member(Producto,Lista).

%4) Cantidad de productos habilitados de un determinado cliente.
contar(Cliente,Total):-
	cliente(Cliente,_,Lista),
	length(Lista,Total).

%5) Calcular la cantidad maxima de un producto que solicita un cliente.
maximo(Cliente,Producto,Total):-
	verificar(Cliente,Producto),
	cliente(Cliente,CantidadMaxima,_),
	producto(Producto,Precio,_,_),
	Total is CantidadMaxima/Precio. 

%6) Determinar el mayor despacho posible de la terminal de un producto comercial.
despachoMaximo(Producto,Despacho):-
	producto(Producto,_,Base,Bio),
	porcentaje(Bio,Porcentaje),
	suma(Base,CantidadMaximaBase),
	suma(Bio,CantidadMaximaBio),
	CantidadMaximaBio >= (CantidadMaximaBase * Porcentaje)/(1 - Porcentaje),
	Despacho is CantidadMaximaBase/(1 - Porcentaje).
