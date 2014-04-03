# Automata Finito No-Determinista.
```
% Descripcion del automata
% s4 es el estado final
final(s4).
% transicion de s1 a s2 cuando la entrada es X
trans(s1, a, s2).
trans(s2, c, s4).
trans(s2, b, s3).
trans(s3, c, s4).
% transiciones que no producen cambio de estado.
trans(s1, a, s1).
trans(s1, b, s1).
trans(s2, b,s2).
acepta(Estado, []) :-
					final(Estado).
acepta(Estado,[C|Resto]) :-
					trans(Estado, C, Estado2),
                    acepta(Estado2, Resto).
```

![](https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-frc3/t1.0-9/10006990_788229544521941_1662568937_n.jpg)
