%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Tarea de Prolog. Caso : Ir de Compras. %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%
%% Hechos %%
%%%%%%%%%%%%

% Precios(Cuidados)
costo(yerba,15).
costo(carne,20).
costo(arroz,6).
costo(leche,5).
costo(pata_de_chancho,25).
costo(manzana,13).
costo(fideos,6).
costo(tomates,11).
costo(cangrejo,23).
costo(chicha_morada,99999999).

% Necesidades 
leFalta(juan,yerba).
leFalta(juan,tomates).
leFalta(maria,manzana).
leFalta(sofia,fideos).
leFalta(enzo,cangrejo).
leFalta(matias,arroz).
leFalta(enzo,chicha_morada).
leFalta(martina,carne).

% Dinero en la billetera.
billetera(juan,13).
billetera(maria,20).
billetera(enzo,40).
billetera(matias,6).

% Amigos del vendedor.
amigo(juan,cacho).
amigo(matias,cacho).

% Compradores con Tarjeta 
tieneTarjeta(martina,visa).
tieneTarjeta(juan,sube).

%%%%%%%%%%%%
%% Reglas %%
%%%%%%%%%%%%
vaComprar(Persona,Producto) :- leFalta(Persona,Producto) , tieneDinero(Persona,Producto).
	tieneDinero(Persona,Producto) :- costo(Producto,Precio) , billetera(Persona,Dinero) , Dinero > Precio.
vaComprar(Persona,Producto) :- leFalta(Persona,Producto) , tieneTarjeta(Persona,Tarjeta) , Tarjeta = visa.
vaComprar(Persona,Producto) :- leFalta(Persona,Producto) , leFian(Persona,Vendedor).
	leFian(Persona,Vendedor) :- amigo(Persona,Vendedor) , Vendedor = cacho.
	
