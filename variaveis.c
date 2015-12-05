#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "otimizador.h"
#include "lista.h"
#include "variaveis.h"

void comments_unused_variable(list *variable, header *fixed_header){
    list * aux_list = variable;
    while(aux_list->character != ';') {
        aux_list = aux_list->next;
    }
    aux_list->successor = aloc_string(" // Variável não utilizada");
}

void not_declarated_init(list *variable, header *fixed_header){
    variable->previous->predecessor = aloc_string("// ");
    variable->next->successor = aloc_string(" // Variável não utilizada");
}

void variable_not_declarated_alone(list *in_element, header *fixed_header) {
    int more_one = 0;
    list *variable = in_element, *aux_list = fixed_header->head;
    more_one = how_many_times(fixed_header, variable);

    if(more_one <= 1) {
        if (strcmp(variable->previous->string, ", ")){
            if(variable->next->character == ';') {
                not_declarated_init(variable, fixed_header);
            }
            else if(variable->next->string) {
                if(!strcmp(variable->next->string, " = ")) {
                    if(variable->next->next->character == '\'') {
                        variable->previous->predecessor = aloc_string("// ");
                        comments_unused_variable(variable, fixed_header);
                    }
                    else if(variable->next->next->next->character == ';') {
                        variable->previous->predecessor = aloc_string("// ");
                        comments_unused_variable(variable, fixed_header);
                    }
                }
                else if (!strcmp(variable->next->string, ", "))
                {
                    variable->predecessor = aloc_string("/*h ");
                    variable->next->successor = aloc_string(" h*/");
                }
            }
        } 
    }
}

void variable_not_declarated_middle(list *in_element, header *fixed_header) {
    int more_one = 0;
    list *variable = in_element, *aux_list;
    more_one = how_many_times(fixed_header, variable);
    
    if(more_one <= 1) {
        variable->previous->predecessor = aloc_string("/* ");
        variable->successor = aloc_string(" */ ");
        comments_unused_variable(variable, fixed_header);
    }
}

void variable_not_declarated_equals(list *in_element, header *fixed_header) {
    int more_one = 0;
    list *variable = in_element, *aux_list;
    more_one = how_many_times(fixed_header, variable);

    if(more_one <= 1) {
        variable->previous->predecessor = aloc_string("/* ");
        variable->next->next->successor = aloc_string(" */ ");
        comments_unused_variable(variable, fixed_header);
    }
}