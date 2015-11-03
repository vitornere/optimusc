#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "otimizador.h"
#include "lista.h"

void variable_not_declarated(list *in_element, header *fixed_header) {
    int i, more_one = 0;
    list *variable = in_element->next, *aux_list = fixed_header->head;

    for(i = 0; i<fixed_header->n_elem; i++) {
        if(aux_list && aux_list->string) {
            if(!strcmp(aux_list->string, variable->string)) {
                more_one++;
            }
        }

        aux_list = aux_list->next;
    }

    if(more_one == 1) {
        variable->previous->predecessor = (char*)malloc(4*sizeof(char));
        strcpy(variable->previous->predecessor, "\\ ");

        if(!strcmp(variable->next->string, " = ")) {
            variable->next->next->successor = (char*) malloc(24*sizeof(char));
            strcpy(variable->next->next->successor, " Variável não utilizada");
        }
        else {
            variable->next->successor = (char*) malloc(24*sizeof(char));
            strcpy(variable->next->successor, " Variável não utilizada");
        }
    }
    else if(!more_one) {
        printf("\n\n Erro na análise de variável não utilizada\n\n");
        exit(1);
    }
}


void optimize(header *fixed_header) {
    int i;
    list *in_element = fixed_header->head;

    for(i = 0; i<fixed_header->n_elem; i++) {
        if(in_element->string) {
            if(!strcmp(in_element->string, "char ") || !strcmp(in_element->string, "int ")
               || !strcmp(in_element->string, "float ")) {
                variable_not_declarated(in_element, fixed_header);
            }
        }

        in_element = in_element->next;
    }
}
