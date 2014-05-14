%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(erikElRojo,25,70)).
 
comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
comio(timon, cucaracha(cucurucha,12,5)).
 
comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).
 
pesoHormiga(2).
 
%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).

% 1)
jugosita(cucaracha(Nombre,Tam,Peso)):-
										comio(_, cucaracha(Nombre,Tam,Peso)),	
										comio(_, cucaracha(Nombre2,Tam, Peso2)),
										Nombre \= Nombre2,
										Peso > Peso2.

hormigofilico(Personaje):-
							comio(Personaje,_),
							findall(Hormiga,comio(Personaje,hormiga(Hormiga)),ListaHormigas),
							length(ListaHormigas,Largo),
							Largo >= 2.

cucarachafobico(Personaje):-
							comio(Personaje,_),
							not(comio(Personaje, cucaracha(_,_,_))).
