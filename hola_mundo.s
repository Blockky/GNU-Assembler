.data
    msg1: .ascii "¡Hola Mundo!\n"
    len1 = . - msg1
    msg2: .ascii "\n!Hola gente de la EPS!\n"
    len2 = . - msg2

/* La sección .data sirve para almacenar varibles que se usarán más
adelante en el programa, son datos estáticos. Por otra parte, en la
sección .text se escriben las instrucciones de código ejecutable */

.text
    .global _start      /* Con la sección .global definimos que _start sea el punto de
                        entrada del programa. En sistemas Linux, el cargador del sistema 
                        (ld.so) buscará _start como la primera instrucción que se ejecutará */
_start:
    /* Imprimir el primer mensaje por pantalla */
    movl  $4,     %eax
    movl  $1,     %ebx  
    movl  $msg1,  %ecx
    movl  $len1,  %edx
    int   $0x80

    /* Imprimir el segundo mensaje por pantalla */
    movl  $4,     %eax
    movl  $1,     %ebx  
    movl  $msg2,  %ecx
    movl  $len2,  %edx
    int   $0x80

    /* Finalizamos el programa */
    movl  $1,   %eax
    movl  $0,   %ebx
    int   $0x80
