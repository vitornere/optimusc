#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "otimizador.h"
#include "lista.h"

int how_many_times(header *fixed_header, list *variable) {
    int more_one = 0, i;
    list *aux_list = fixed_header->head;

    for(i = 0; i<fixed_header->n_elem; i++) {
        if(aux_list && aux_list->string) {
            if(!strcmp(aux_list->string, variable->string)) {
                if(aux_list->next->string) {
                    if(!more_one) {
                        more_one++;
                    }
                    else if(strcmp(aux_list->next->string, " = ")) {
                        more_one++;
                    }
                }
            }
        }

        aux_list = aux_list->next;
    }

    return more_one;
}

void variable_not_declarated_alone(list *in_element, header *fixed_header) {
    int more_one = 0;
    list *variable = in_element, *aux_list = fixed_header->head;

    if(variable->previous->string) {
        if(strcmp(variable->previous->string, ", ") && variable->next->character == ';') {
            more_one = how_many_times(fixed_header, variable);
            if(more_one <= 1) {
                variable->previous->predecessor = aloc_string("//");

                variable->next->successor = aloc_string(" // Variável não utilizada");
            }
        }
        else if(variable->next->string) {
            if(strcmp(variable->previous->string, ", ") && !strcmp(variable->next->string, " = ")) {
                more_one = how_many_times(fixed_header, variable);
                if(more_one <= 1) {
                    if(variable->next->next->character == '\'' && variable->next->next->next->next->next->character == ';') {
                        variable->previous->predecessor = aloc_string("//");

                        variable->next->next->next->next->next->successor = aloc_string(" // Variável não utilizada");
                    }
                    else if(variable->next->next->next->character == ';') {
                        variable->previous->predecessor = aloc_string("//");

                        variable->next->next->next->successor = aloc_string(" // Variável não utilizada");
                    }
                }
            }
        }
    }
}

void variable_not_declarated_middle(list *in_element, header *fixed_header) {
    int more_one = 0;
    list *variable = in_element, *aux_list;

    if(variable->previous->string && variable->next->string) {
        if(!strcmp(variable->previous->string, ", ") && !strcmp(variable->next->string,", ")) {
            more_one = how_many_times(fixed_header, variable);

            if(more_one <= 1) {
                variable->predecessor = aloc_string("/* ");

                variable->next->successor = aloc_string("*/ ");

                aux_list = variable;
                
                while(aux_list->character != ';') {
                    aux_list = aux_list->next;
                }

                aux_list->successor = aloc_string(" // Variável não utilizada");
            }
        } 
    }
}


void optimize(header *fixed_header) {
    int i;
    list *in_element = fixed_header->head, *aux_list;

    for(i = 0; i<fixed_header->n_elem; i++) {
        if(in_element->string) {
            aux_list = in_element;
            if(!strcmp(in_element->string, "char ") || !strcmp(in_element->string, "int ")
                || !strcmp(in_element->string, "float ")) {
                aux_list = aux_list->next;
                do {
                    if(aux_list->string) {
                        variable_not_declarated_alone(aux_list, fixed_header);
                        variable_not_declarated_middle(aux_list, fixed_header);
                    }
                    aux_list = aux_list->next;
                } while(aux_list->character != ';');
            }
        }

        in_element = in_element->next;
    }
}
