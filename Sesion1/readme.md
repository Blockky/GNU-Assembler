## Aclaraciones de la primera sesión:
<p>En este laboratorio tratamos el código y programamos para arquitecturas x86 de 32 bits, por lo que los únicos registros de memoria con los que trabajamos son los siguientes: </p>
<p align="center">
<img src="https://github.com/Blockky/GNU-Assembler/blob/main/Sesion1/x86-registers.png" alt="x86" width=400 />
</p>
<p>Como bien se indica en la imagen, los registros de proposito general que usaremos son EAX, EBX, ECX, EDX, ESI y EDI. Cada registro suele tener una o varias funcionalidades específicas, y además, como se observa, los 4 primeros registros tienen unas subceldas, las cuales forman parte del registro padre. Un ejemplo sería, si manipulamos el registro AL (8bits), en verdad estamos manipulando los 8 bits menos significativos del registro padre EAX (32 bits). </p>

