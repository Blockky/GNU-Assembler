## Servicios int $0x80 utilizados:
Para realizar un determinado servicio haciendo llamadas al sistema con int $0x80 se toma en cuenta que:
- En EAX debe de ir el número del servicio a realizar
- En EBX, ECX, EDX, EDI, ESI y EBP deben de ir los parametros necesarios para realizar el servicio

En la siguiente página se encuentra una lista de los posibles servicios que puede ejecutar los sitemas Linux con arquitecturas x86:
https://syscalls.w3challs.com/?arch=x86

En la primera parte de esta práctica se usan los servicios:

SYS_WRITE (4)
SYS_READ (3)
SYS_EXIT (1)
