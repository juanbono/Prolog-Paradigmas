%%%%%%%%%%%%
%% Hechos %%
%%%%%%%%%%%%

% Examenes de la vista.
vision(julian,3).
vision(federico,2).
vision(emanuel,1).
vision(martina,3).
vision(eduardo,2).
vision(juan,8356).

% informacion general
%% Carrera
carrera(julian,sistemas).
carrera(federico,sistemas).
carrera(emanuel,mecanica).
carrera(martina,sistemas).
carrera(eduardo,sistemas).

%% Habilidades
manejaArma(julian,cuchillo_tramontina).
manejaArma(eduardo,assembler).

esAsesino(Persona) :- tieneAnteojos(Persona) , caraSospechosa(Persona) , manejaArma(Persona,Arma).
	tieneAnteojos(Persona) :- vision(Persona,Vista) , Vista < 4 .
	caraSospechosa(Persona) :- carrera(Persona,Especialidad), Especialidad = sistemas.
