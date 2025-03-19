## Manipulacion de archivos

Uso del servicio 5 (SYS_OPEN)

Este servicio sirve para abrir o crear un fichero en nuestro ordenador

- En el primer parámetro (%ebx) debemos de introducir la ruta de nuestro archivo (en caso de que no exista, crea el archivo en la ruta especificada)
- En el segundo (%ecx) deben de ir las banderas, que son los modos de acceso al archivo
- Y en el último (%edx) deben de ir los modos, el cual es solo necesario al crear el archivo
- Una vez realizado el servicio, se retorna el descriptor del archivo en %eax

Banderas (modos de acceso)

{00000} O_RDONLY: sólo lectura
{00001} O_WRONLY: sólo escritura
{00002} O_RDWR: lectura y escritura
{02000} O_APPEND: el ﬁchero se abre en modo append de forma que las sucesivas escrituras se añaden
{00100} O_CREAT: si la ruta pasada como argumento no existe, se crea el ﬁchero
