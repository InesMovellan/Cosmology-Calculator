# Cosmology-Calculator
1. Descripción del código
El software consta de dos scripts. El código principal, CalculadoraCosmologica.m
y el main.m, que permite ejecutar el programa. Para obtener los resultados expuestos
en la sección 2 se ha definido una clase con una serie de funciones, que permiten
determinar cada una de las magnitudes explicadas. Estas funciones se describen en
los siguientes puntos.

1.1. Distancias
Para obtener las distancias de luminosidad y de diámetro angular se ha definido
la función E(z) como aparece en la Ec. 5 - 8, y la coordenada radial σ(z), Ec. 7. Para
esta última, en primer lugar, se ha seguido una estructura if - then, de forma que se
contempla el caso en el que la curvatura sea nula (Ec. 8). Se ha inicializado el array
sigma, con el mismo tamaño que el array z (redshift z), definido en el main. Mediante
un bucle for se calcula el valor de cada elemento del array sigma, empleando para
ello el comando integral de MATLAB. Esta instrucción integra de forma numérica
mediante cuadratura adaptativa global, con tolerancias de error predeterminadas [2].
Obtenido el array sigma, se calculan las distancias de luminosidad y de diámetro
angular a partir de las Ec. 9 y 10 de la misma forma, inicializando los array distL
y distA, recorriéndolos con un bucle for y llamando a la función sigma, calculando
ası́ el valor de cada elemento del array.

1.2. Factor de escala
Para obtener el factor de escala se ha definido E(z) en función de a. Para esto,
se ha sustituido 1+z en la Ec. 5 por la Ec. 6. Hecho esto, se ha resuelto la ecuación
diferencial mediante la instrucción ode45 de MATLAB. Esta instrucción es un méto-
do de orden medio que permite resolver EDOs no rı́gidas [2], integrando la ecuación
diferencial con la condición inicial fijada a(0) = 1. El resultado de esta función es
una matriz de dos columnas, siendo la primera el tiempo, y la segunda el factor de
escala para ese tiempo.

1.3. Parámetro de Hubble
El parámetro de Hubble se obtiene a partir de la función que define el factor
de escala, aplicando la Ec. 5. Se llama a la función que define el factor de escala,
y, a partir de la segunda columna de la matriz que da como output, se obtiene,
recorriendo H(t) con un bucle for, el valor de cada elemento del array parámetro de
Hubble.

1.4. Radio de Hubble
El radio de Hubble se obtiene aplicando la Ec. 11. El denominador de dicha
ecuación es la función parámetro de Hubble definida en el apartado anterior.

1.5. Horizonte de partı́culas
Para determinar el horizonte de partı́culas se emplea la Ec. 12. En primer lugar,
se inicializa el array HP y se obtiene la segunda columna de la matriz output de la
función factor de escala. Se recorre el array HP con dos bucles for, calculando en
el segundo la integral de la Ec. 12 como el producto de un intervalo temporal por
el valor de la función a(t) en dicho intervalo (integral de Riemann). En el primer
bucle for se multiplica c por dicha integral, obteniendo ası́ el valor de H P para cada
tiempo t.

1.6. Edad del universo
La edad del universo en función del redshift se determina a partir de la Ec. 13.
Se crea el array tiempo y se recorre, calculando, para cada elemento del mismo,
la integral que aparece en la Ec. 13, usando para ello la instrucción integral de
MATLAB.

2. Ejecución del programa
Como se ha explicado en la sección 4.1, para ejecutar el programa se compila
el main. En primer lugar se abren los dos scripts con MATLAB. Tras esto, se fijan
en CalculadoraCosmologica.m los parámetros cosmológicos de interés, permitiendo
este programa estudiar simultáneamente hasta cinco universos diferentes. Fijados los
parámetros cosmológicos, en el main se puede cambiar el redshift, que es un array
que, por defecto, está definido entre 0 y 15. Mediante este código, es posible obtener
un total de siete figuras, que se corresponden a las dos distancias, el factor de escala
y parámetro de Hubble, el radio de Hubble y el horizonte de partı́culas y, por último,
la edad del universo. Para esta última se determina también el caso particular de la
edad actual del universo.
