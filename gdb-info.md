GDB es el GNU Debugger, una herramienta de depuración utilizada en sistemas Unix/Linux para programas escritos en lenguaje ensamblador y otros compatibles.

Este depurador te permite:

- Ejecutar tu programa paso a paso (step-by-step)
- Poner breakpoints (puntos de interrupción) en el código
- Inspeccionar el valor de variables y estructuras de datos
- Modificar el valor de variables durante la ejecución
- Ver el contenido de la memoria y registros
- Analizar el stack trace cuando el programa se cae (segmentation fault, por ejemplo)
- Investigar por qué el programa se quedó colgado o está comportándose mal

La forma en la que usaremos este depurador será la siguiente:
```
PARA EJECUTAR EL DEPURADOR EN NUESTRO PROGRAMA ESCRIBIMOS EN EL TERMINAL:
gdb 'ejecutable'

CON BREAK DEFINIMOS A PARTIR DE QUE SECCIÓN DEL CÓDIGO QUEREMOS INSPECCIONAR
break 'etiqueta'

PARA EJECUTAR EL PROGRAMA HASTA NUESTRO PUNTO DE RUPTURA (BREAK) ESCRIBIMOS:
run (r)

PARA EJECUTAR LA SIGUIENTE LÍNEA DE NUESTRO CÓDIGO ESCRIBIMOS:
stepi (s)

PARA VER EL CONTENIDO DE LOS REGISTROS ESCRIBIMOS:
info register (i r)

PARA SALIR DEL DEPURADOR ESCRIBIMOS:
quit (q)
