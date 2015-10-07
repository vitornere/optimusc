calc: lexico.l sintatico.y
	bison -d sintatico.y
	mv sintatico.tab.h sintatico.h
	mv sintatico.tab.c sintatico.c
	flex lexico.l
	mv lex.yy.c lexico.c
	gcc -o optimus.exe sintatico.c lexico.c

clean:
	rm -f *~ sintatico.h sintatico.c lexico.c