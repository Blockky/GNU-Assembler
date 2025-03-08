## Desplazamientos, comparaciones y saltos

En GAS se pueden realizar saltos a secciones expecíficas de código. Estos saltos pueden ser condicionales o incondicionles.

El salto incondicional (jmp section) salta directamente a la sección especificada una vez se llega a la línea de código que contenga la instrucción.

Los saltos condicionales solo saltan a la sección especificada si se cumple una condición:
<p align="center">
<img src="https://github.com/Blockky/GNU-Assembler/blob/main/Sesion3/saltos.png" alt="x86" width=700 />
</p>

Estas condiciones las declara el valor de las banderas EFLAGS, las cuales se ven modificadas tras realizar desplazamientos, rotaciones u otras instrucciones como comparaciones. Las comparaciones que estudiamos son las que realizan las instrucciones (cmp) y (test). 

La instrucción (cmp) realiza una resta entre dos operandos y actualiza los flags, pero no almacena el resultado.

La instrucción (test) realiza una operación AND bit a bit entre dos operandos y actualiza los flags, pero no almacena el resultado.

Las banderas se actualizan de la siguiente manera:
<p align="center">
<img src="https://github.com/Blockky/GNU-Assembler/blob/main/Sesion3/flags.png" alt="x86" width=700 />
</p>
