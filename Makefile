calc: teste.l teste.y
	bison -d teste.y
	mv teste.tab.h sintatico.h
	mv teste.tab.c sintatico.c
	flex teste.l
	mv lex.yy.c lexico.c
	gcc -o calc.exe sintatico.c lexico.c