#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "otimizador.h"
#include "lista.h"
#include "variaveis.h"

int how_many_times(header *fixed_header, list *variable) {
    int more_one = 0, i;
    list *aux_list = fixed_header->head;

    for(i = 0; i<fixed_header->n_elem; i++) {
        if(aux_list && aux_list->string) {
            if(!strcmp(aux_list->string, variable->string)) {
                more_one++;
            }
        }
    aux_list = aux_list->next;
    }

    return more_one;
}

void variable_not_declarated_alone(list *in_element, header *fixed_header) {
    int more_one = 0;
    list *variable = in_element, *aux_list = fixed_header->head;
    more_one = how_many_times(fixed_header, variable);
    if(more_one <= 1) {
        if(strcmp(variable->previous->string, ", ") && variable->next->character == ';') {
            variable->previous->predecessor = aloc_string("//");

            variable->next->successor = aloc_string(" // Variável não utilizada");
        }
        else if(variable->next->string) {
            if(strcmp(variable->previous->string, ", ") && !strcmp(variable->next->string, " = ")) {
                if(variable->next->next->character == '\'' && variable->next->next->next->next->next->character == ';') {
                    variable->previous->predecessor = aloc_string("//");

                    variable->next->next->next->next->next->successor = aloc_string(" // Variável não utilizada");
                }
                else if(variable->next->next->next->character == ';') {
                    variable->previous->predecessor = aloc_string("//");

                    variable->next->next->next->successor = aloc_string(" // Variável não utilizada");
                }
            }
            else if (strcmp(variable->previous->string, ", ") && !strcmp(variable->next->string, ", "))
            {
                variable->predecessor = aloc_string("/*-- ");

                variable->successor = aloc_string("----*/");
            }
        }
    }
}

void variable_not_declarated_middle(list *in_element, header *fixed_header) {
    int more_one = 0;
    list *variable = in_element, *aux_list;
    
    more_one = how_many_times(fixed_header, variable);
    if(more_one <= 1) {
        variable->previous->predecessor = aloc_string("/* 1111");
        variable->successor = aloc_string(" 1111*/ ");
        aux_list = variable;

        while(aux_list->character != ';') {
            aux_list = aux_list->next;
        }

        aux_list->successor = aloc_string(" // Variável não utilizada");
    }
}

void variable_not_declarated_tail(list *in_element, header *fixed_header) {

    int more_one = 0;
    list *variable = in_element, *aux_list;

    more_one = how_many_times(fixed_header, variable);

    if(more_one <= 1) {
        variable->previous->predecessor = aloc_string("/* ");

        variable->successor = aloc_string(" */ ");
        aux_list = variable;
        
        while(aux_list->character != ';') {
            aux_list = aux_list->next;
        }
        aux_list->successor = aloc_string(" // Variável não utilizada");
    }
}

void variable_not_declarated_equals(list *in_element, header *fixed_header) {
    int more_one = 0;
    list *variable = in_element, *aux_list;
    more_one = how_many_times(fixed_header, variable);

    if(more_one <= 1) {

        variable->previous->predecessor = aloc_string("/* ");
        variable->next->next->successor = aloc_string(" */ ");
        aux_list = variable;

        while(aux_list->character != ';') {
            aux_list = aux_list->next;
        }
        
        aux_list->successor = aloc_string(" // Variável não utilizada");
    }
}