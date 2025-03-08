main:
	as -o char.o -g char.s --32
	ld -melf_i386 -o char char.o
clean: char char.o
	rm char char.o