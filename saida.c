#include <stdio.h>
#include "minha_biblioteca.h"

float teste(int numberOne, char c) {

// 	char oi; // Variável não utilizada
}

/* 
int nUtilizada() {

// 	float ameba; // Variável não utilizada
}
*/ // Função não utilizada 

int main() {

	int numberOne/* , notUsedEqaul = 10 */ /* , notUsedAlone */ , usedTail; // Variável não utilizada
	int intEqual = 3;
// 	int notUsedIntEqual = 3; // Variável não utilizada
// 	int testeNutil; // Variável não utilizada
	float usedReal = 1.000000/* , notUsedFloat */ /* , alone = 1.000000 */ ; // Variável não utilizada
	float bolinha = 3.000000;
	float /* outro,  */floatUtil, nUtilFloat;
	float /* messi,  */neymar/* , cr7 */ ; // Variável não utilizada
	char vasco = 'b'/* , flamengo */ /* , testeRecursivoCharAgain */ ; // Variável não utilizada
	char palavra/* , frase */ ; // Variável não utilizada
// 	char notUsedChar = 'k'; // Variável não utilizada

	if(0) {
		numberOne = 1;
		bolinha = 5.000000;
		intEqual = (intEqual - 2) + bolinha + numberOne;
	}

	if(numberOne > 5) {
		int c = 3;
	}

	if(numberOne > 5 && numberOne < 4 || numberOne == 10 && intEqual != numberOne) {
		floatUtil = 3.000000 + 3.000000 - 3;
		usedTail = usedReal + floatUtil * floatUtil;
	}
	else if(numberOne > 3 || (numberOne + 23) != intEqual) {
		numberOne = 3 * (3 - bolinha) / 2;
		vasco = numberOne;
	}
	else {
		nUtilFloat = 4.500000 * (4 + numberOne) * (2 - b);
		neymar = neymar - nUtilFloat;
	}
	printf(	"Funcionando legal");
	teste(intEqual, palavra);
	
return 0;
}
