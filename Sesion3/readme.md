## Desplazamientos, comparaciones y saltos

En GAS se pueden realizar saltos a secciones expecíficas de código. Estos saltos pueden ser condicionales o incondicionales.

El salto incondicional (jmp section) salta directamente a la sección especificada.

Los saltos condicionales solo saltan a la sección especificada si se cumple una condición:

<a href="https://faydoc.tripod.com/cpu/jz.htm">Saltos condicionales</a>

Estas condiciones las declara el valor de las banderas EFLAGS, las cuales se ven modificadas tras realizar desplazamientos, rotaciones u otras instrucciones como comparaciones. Las comparaciones que estudiamos son las que realizan las instrucciones (cmp) y (test). 

<a href="http://www.c-jump.com/CIS77/ASM/Instructions/I77_0070_eflags_bits.htm">Bit flags</a>

<a href="http://www.c-jump.com/CIS77/ASM/Instructions/I77_0050_eflags.htm">EFLAGS register</a>

La instrucción (cmp) realiza una resta entre dos operandos y actualiza los flags, pero no almacena el resultado.

La instrucción (test) realiza una operación AND bit a bit entre dos operandos y actualiza los flags, pero no almacena el resultado.

Las banderas se actualizan de la siguiente manera:
<p align="center">
<img src="https://github.com/Blockky/GNU-Assembler/blob/main/Sesion3/comp.png" alt="x86" width=700 />
</p>
<p align="center">
<img src="https://github.com/Blockky/GNU-Assembler/blob/main/Sesion3/flags.png" alt="x86" width=700 />
</p>
