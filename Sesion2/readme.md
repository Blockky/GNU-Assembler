## Servicios int $0x80 utilizados
<p>Para realizar un determinado servicio haciendo llamadas al sistema con int $0x80 se toma en cuenta que:</p>

- En EAX debe de ir el número del servicio a realizar
- En EBX, ECX, EDX, EDI, ESI y EBP deben de ir los parametros necesarios para realizar el servicio
- Si la llamada al sistema devuelve un valor, este valor será colocado en EAX

<p>En la siguiente página se encuentra una lista de los posibles servicios que puede ejecutar los sitemas Linux con arquitecturas x86:</p>
<p><a href="https://syscalls.w3challs.com/?arch=x86">Lista de servicios </p>
<p>En la primera parte de esta práctica se usan los servicios:</p>

<p>SYS_WRITE (4)</p>
<p>SYS_READ (3)</p>
<p>SYS_EXIT (1)</p>
