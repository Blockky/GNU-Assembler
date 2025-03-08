.data
    fichero: .asciz "./personal.txt"
    tam = 10+1
    msg_edad: .asciz "\nEscriba la edad:\n"
    len_edad = . - msg_edad
    msg_nombre: .asciz "\nEscriba el nombre:\n"
    len_nombre = . - msg_nombre
    msg_final: .asciz "\n¿Desea añadir un nuevo registro? (s para terminar)\n"
    len_final = . - msg_final
    buf_edad: .space tam
    buf_nombre: .space tam
    buffer: .space 1+1
    newline: .asciz "\n"
    tab: .asciz "\t"

.text
    .global _start
_start:

iniciar:
    /* Crear-abrir el archivo de texto */
    movl  $5,         %eax
    movl  $fichero,   %ebx
    movl  $02101,     %ecx
    movl  $0666,      %edx
    int   $0x80

    /* Guardar el descriptor del archivo en %edi */
    movl  %eax,       %edi

    /* Solicitar que se escriba el nombre */
    movl  $len_nombre,   %edx
    movl  $msg_nombre,   %ecx
    movl  $1,            %ebx
    movl  $4,            %eax
    int   $0x80

    /* Leer cadena desde el teclado */
    movl  $3,           %eax
    movl  $0,           %ebx
    movl  $buf_nombre,  %ecx
    movl  $tam,         %edx
    int   $0x80

    /* Solicitar que se escriba la edad */
    movl  $len_edad,   %edx
    movl  $msg_edad,   %ecx
    movl  $1,          %ebx
    movl  $4,          %eax
    int   $0x80

    /* Leer cadena desde el teclado */
    movl  $3,           %eax
    movl  $0,           %ebx
    movl  $buf_edad,    %ecx
    movl  $tam,         %edx
    int   $0x80

    /* Escribir los registros */
    movl  $4,           %eax
    movl  %edi,         %ebx
    movl  $buf_nombre,  %ecx
    movl  $tam,         %edx
    int   $0x80

    movl  $4,           %eax
    movl  %edi,         %ebx
    movl  $tab,         %ecx
    movl  $2,           %edx
    int   $0x80

    movl  $4,           %eax
    movl  %edi,         %ebx
    movl  $buf_edad,    %ecx
    movl  $tam,         %edx
    int   $0x80

    movl  $4,           %eax
    movl  %edi,         %ebx
    movl  $newline,     %ecx
    movl  $2,           %edx
    int   $0x80

    /* Cerrar el archivo de texto*/
    movl  $6,         %eax
    movl  %edi,       %ebx
    int   $0x80
    
    /* Solicitar si registrar más datos */
    movl  $len_final,    %edx
    movl  $msg_final,    %ecx
    movl  $1,            %ebx
    movl  $4,            %eax
    int   $0x80

    /* Leer caracter desde el teclado */
    movl  $3,           %eax
    movl  $0,           %ebx
    movl  $buffer,      %ecx
    movl  $2,           %edx
    int   $0x80

    /* Comparar el caracter con "s" */
    movb  buffer,   %al
    cmpb  $'s',     %al
    je finalizar

    jmp iniciar /* Repetir proceso */

finalizar:
    /* Finalizar el programa */
    movl  $1,     %eax
    movl  $0,     %ebx
    int   $0x80
