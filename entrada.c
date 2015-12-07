#include <stdio.h>
#include "minha_biblioteca.h"

float teste(int numberOne, char c){
	char oi;	
}

int nUtilizada() {
	float ameba;
}

int main(){

	int numberOne, notUsedEqaul = 10, notUsedAlone, usedTail;
	int intEqual = 3;
	int notUsedIntEqual = 3;
	int testeNutil;
	float usedReal = 1.0, notUsedFloat, alone = 1.00;
	float bolinha = 3.0;
	float outro, floatUtil, nUtilFloat;
	float messi, neymar, cr7;
	char vasco = 'b', flamengo, testeRecursivoCharAgain;
	char palavra, frase;
	char notUsedChar = 'k';

	if(0) {
		numberOne = 1;
		bolinha = 5.0;
		intEqual = (intEqual - 2) + bolinha + numberOne;
	}

	if(numberOne>5) {
		int c = 3;
	}

	if(numberOne > 5 && numberOne < 4 || numberOne == 10 && intEqual != numberOne) {
		floatUtil = 3.0 + 3.0 - 3;
		usedTail = usedReal + floatUtil * floatUtil;
	}
	else if (numberOne > 3 || (numberOne + 23) != intEqual){
		numberOne = 3 * (3 - bolinha) / 2;
		vasco = numberOne;
	}
	else {
		nUtilFloat = 4.5 * (4 + numberOne) * (2 -b);
		neymar = neymar - nUtilFloat;
	}

	printf("Funcionando legal");
	teste(intEqual, palavra);

	return 0;
	
}
