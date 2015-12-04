#include <stdio.h>
#include "minha_biblioteca.h"

float teste(int x, char c) {

//	char oi; // Variável não utilizada
}

int main() {

	int x, nUtilAtribuida = 10;
	int y = 3/* , yy */ ; // Variável não utilizada
	float real = 1.000000/* 1111, yu 1111*/ , i = 1.000000; // Variável não utilizada
//	int testeNutil; // Variável não utilizada
//	char d = 'k'; // Variável não utilizada
	float /*-- realMenor----*//* 1111, outro 1111*/ , floatUtil, nUtilFloat; // Variável não utilizada
	char b = 'b'/* 1111, utilizada 1111*/ /* , testeRecursivoCharAgain */ ; // Variável não utilizada
	char a/* , mamada */ ; // Variável não utilizada
	float bolinha = 3.000000;

	if(0) {
		x = 1;
		bolinha = 5;
		y = 2;
	}

	if(x > 5) {
		int c = 3;
	}

	if(x > 5 && x < 4 || x == 10 && y != x) {
		floatUtil = 3.000000 + 3.000000 - 3;
		floatUtil = real + floatUtil;
	}
	else if(x > 3 || (x + 23) != y) {
		x = 3 * (3 - a) - a / 2;
	}
	else {
		nUtilFloat = 4.500000 * (4 + x) * a * (2 - b);
	}
	printf(2, 3);
	teste();
	
return 0;
}
