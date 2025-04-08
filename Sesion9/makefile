main:
	as -o decod.o -g decod.s --32
	ld -melf_i386 -o decod decod.o
clean:
	rm decod decod.o