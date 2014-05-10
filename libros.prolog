%Venta de Libros
%a) Primera parte
%Una editorial quiere hacer distintos análisis de las cifras de ventas de sus libros. Para ello define por
%extensión el predicado libro/3:
% libro(autor, título, cantidad de ejemplares vendidos)


libro(garciaMarquez, elAmor, 50000).
libro(garciaMarquez, cienAnios, 100000).
libro(garciaMarquez, cronica, 40000).
libro(garciaMarquez, ojos, 35000).
libro(borges, ficciones, 70000).
libro(borges, aleph, 80000).
libro(orwell, 1984, 120000).
libro(orwell, rebelion, 50000).



%1. Definir el predicado todosAlMenos/2, que relaciona un autor con una cantidad de ejemplares de
%libro, si todos los libros de dicho autor se vendieron en al menos dicha cantidad de ejemplares.
%?todosAlMenos(
%orwell,40000).
%true
%porque de todos los libros de Orwell se vendieron al menos 40000 ejemplares.


todosAlMenos(Autor,Cantidad):-
								forall(libro(Autor,_,Ejemplares),Ejemplares >= Cantidad).





% 2. Definir el predicado noEsDeNinguno/2, que relaciona una lista de autores con un libro si ninguno de
% los autores escribió dicho libro.Por ejemplo, se verifica
% ?noEsDeNinguno([
% garciaMarquez,orwell],aleph).
% porque El Aleph no es de García Márquez ni de Orwell.

noEsDeNinguno(ListaAutores,Libro):-
									libro(_,Libro,_),
									not(member(Libro,ListaAutores)).

%% +++++++++++++++++++ Segunda Parte ++++++++++++++++++++++ %%
libro(garciaMarquez, novela(elamor), 50000).
libro(garciaMarquez, novela(cienAnios), 100000).
libro(garciaMarquez, novela(cronica), 40000).
libro(garciaMarquez, cuentos(ojos, [azul,isabel,mamaGrande],35000).
libro(borges, cuentos(ficciones, [funes, tlon, senderos]), 70000).
libro(borges, cuentos(aleph, [cruz, zahir]), 80000).
libro(orwell, novela(1984), 120000).
libro(orwell, novela(rebelión), 50000).
% Modificar los predicados de la primer parte para contemplar las modificaciones realizadas.


autorLibro(Autor,Titulo):- libro(Autor,novela(Titulo),_).

autorLibro(Autor,Titulo):- libro(Autor,cuento(Titulo,_),_).

noEsDeNinguno(ListaAutores,Libro):-
									autorLibro(Autor,Titulo)
									not(member(Libro,ListaAutores)).






% En el punto 2, tener en cuenta que las consultas se van a seguir haciendo sobre el nombre del libro, no
% sobre los functores. O sea por ejemplo, la consulta no va a ser
% ?noEsDeNinguno([
% garciaMarquez,orwell], cuentos(aleph, [cruz, zahir])).
% sino que va a seguir siendo
% noEsDeNinguno([garciaMarquez,orwell],aleph).
