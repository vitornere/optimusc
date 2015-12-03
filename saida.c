#include <stdio.h>
#include "minha_biblioteca.h"

float teste(int x, char c) {

//	char oi; // Variável não utilizada
}

int main() {

	int x/* , nUtilizadaInt */ , nUtilAtribuida = 10; // Variável não utilizada
	int y = 3;
	float real = 1.000000/* , yu */ , i = 1.000000; // Variável não utilizada
//	int testeNutil; // Variável não utilizada
//	char d = 'k'; // Variável não utilizada
	float realMenor/* , outro */ , floatUtil, nUtilFloat; // Variável não utilizada
	char b = 'b'/* , utilizada */ /* , testeRecursivoCharAgain */ ; // Variável não utilizada
	char a;
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
	
return 0;
}
