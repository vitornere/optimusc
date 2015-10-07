#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct lista
{
	char *type;
	char *variable;
	char *cacarcter;

	struct lista *next;
	struct lista *previous;
}lista;