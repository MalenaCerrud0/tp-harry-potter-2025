# Harry Potter y los hechizos polimórficos

***J. K. Rowling se acercó a Paradigmas para que la ayudemos a modelar en Smalltalk algunas de sus historias, y como leímos sus libros y vimos sus películas, accedimos.***

## Introducción

Harry Potter es un joven mago que a los 11 años de edad lo enviaron al colegio Hogwarts de Magia y Hechicería. Allí se hizo de amigos como Ron Weasley y Hermione Granger con los que se formó como mago. Como no todo es color de rosas, estando en Hogwarts tuvo que experimentar ciertas aventuras y también pelear repetidas veces contra Lord Voldemort (“el innombrable”).

Nuestro objetivo es modelar la carrera de estos jóvenes magos y sus aventuras.


## El sombrero seleccionador

Al entrar a Hogwarts, todos los alumnos son divididos en 4 casas: Gryffindor, Slytherin, Ravenclaw y Hufflepuff. Un sombrero parlanchín (el sombrero seleccionador) decide qué alumno va a qué casa, a partir de los siguientes criterios:

- Si tiene inteligencia promedio o es pelirrojo puede ir a Gryffindor.
- Si no es un "sangre sucia", puede ir a Slytherin.
- Si es muy inteligente, puede ir a Ravenclaw.
- En cualquier otro caso, puede ir a Hufflepuff.

La medición de inteligencia de la escuela es muy tradicional, y se fija sólo en función del IQ: Muy inteligente a partir de 120, Inteligencia promedio, entre 80 y 120.

El sombrero sigue el mismo orden de como fueron mencionadas las casas, cuando a alguna puede ir, lo manda ahí.


## Seguidores

Un mago puede ser seguidor de otro si es de su misma casa y cumple con alguna de estas condiciones:
- es más inteligente que él.
- es famoso, es decir, tiene más de 3 seguidores.

Obviamente, un mago no puede seguirse a sí mismo.


## Hechizos

Los magos van aprendiendo hechizos para luego poder lanzárselos entre ellos. Cuando llegan a la escuela, los magos tienen una vida de 1000 puntos, cuentan con 1000 unidades de energía y no saben ningún hechizo. Estos niveles de energía y de vida se van modificando en consecuencia de los hechizos, tanto de los que cada mago lanza como de los que reciben.

Los hechizos pueden ser:
- **Sanadores:** Gastan una cantidad de energía fija (cada uno tiene un valor configurable) y le suman el doble de esa energía como puntos de vida al receptor del hechizo. Solo lo pueden aprender aquellos magos que sean famosos. Los magos que estén muertos no pueden ser sanados, aunque el lanzador pierde igual la energía.
- **Combate:** Todos gastan 200 de energía y le restan al receptor el equivalente en puntos de vida a 5 x coeficiente del hechizo + poder de la varita del mago que lo lanza.
Es decir, si Harry Potter tiene una varita con poder = 100 y lanza el hechizo Desmaio de coef = 40, el daño que hará será de 300 puntos de vida (5 x 40 + 100 = 300)
- **Imperdonables:** Los mismos le restan X puntos de vida al lanzador y 2X al receptor, siendo X el coeficiente del hechizo - 4 * cantidad de seguidores del lanzador.

Como consecuencia de lanzar un hechizo, si la vida de un mago (ya sea el que recibe el hechizo como el que lo lanza, según de qué hechizo se trate) disminuye hasta llegar a 0, el mago se muere. 

Si un mago intenta hacer un hechizo que no sabe o no puede hacer (por falta de energía), el hechizo no se realiza.


## Requerimientos

- Dado un mago, saber a qué casa le corresponde ir. 
- Organizar en casas a todos los magos de la escuela. 
- Averiguar si un mago está en la misma casa que otro. 
- Saber si un mago puede seguir otro. 
- Hacer que un mago siga a otro. 
- Hacer que un mago aprenda un hechizo. 
- Saber cuánta energía gastaría un mago al lanzar un hechizo. 
- Representar que un mago lanza un hechizo dado, si es que puede hacerlo. 
- Representar que un mago lanza el hechizo que menos energía gasta.
- Saber si un mago está muerto. 