#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "otimizador.h"
#include "lista.h"
#include "funcoes.h"

void function_not_declarated(list* in_element, header *fixed_header) {
	int more_one = 0;
    list *variable = in_element->next, *aux_list = fixed_header->head, *aux_element = in_element;

    // Verifica se é a declaração de uma função ou a utilização de uma.
    do {
    	if(aux_element->string) {
	    	if(!strcmp(aux_element->string, " {\n\n")) {
	    		break;
	    	}
	    }
    	else if(aux_element->character == ';') {
    		return;
    	}
    	aux_element = aux_element->next;
    } while(1);


    more_one = how_many_times(fixed_header, variable);

    if(more_one<=1) {
    	in_element->predecessor = aloc_string("\n/* ");

    	do {
    		if(aux_element->string) {
    			if(!strcmp(aux_element->string, "}\n")) {
    				break;
    			}
    		}
    		aux_element = aux_element->next;
    	} while(1);
    	aux_element->successor = aloc_string("*/ // Função não utilizada \n");
    }
}