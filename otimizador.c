#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "otimizador.h"
#include "lista.h"
#include "variaveis.h"
#include "funcoes.h"

void function_not_declarated(list *in_element, header *fixed_header) {
    int more_one = 0;
    list *variable = in_element, *aux_list;

    more_one = how_many_times(fixed_header, variable);

    if(more_one <= 1) {

    }
}

void optimize(header *fixed_header) {
    int i;
    list *in_element = fixed_header->head, *aux_list;

    for(i = 0 ; i<fixed_header->n_elem ; i++) {
        if(in_element->string) {
            aux_list = in_element;
            if(!strcmp(in_element->string, "char ") || !strcmp(in_element->string, "int ")
                || !strcmp(in_element->string, "float ")) {
                aux_list = aux_list->next;
                do {
                    if(aux_list->string && aux_list->previous->string) {
                        if(aux_list->next->string) 
                        {
                            if(!strcmp(aux_list->previous->string, ", ") && !strcmp(aux_list->next->string,", ")) 
                                variable_not_declarated_middle(aux_list, fixed_header);
                        }
                        else if(aux_list->next->character)
                        {
                            if(!strcmp(aux_list->previous->string, ", ") && aux_list->next->character == ';')
                                variable_not_declarated_tail(aux_list, fixed_header);
                        }
                        variable_not_declarated_alone(aux_list, fixed_header);
                    }
                    aux_list = aux_list->next;
                } while(aux_list->character != ';');
                if (aux_list->next->character && aux_list->previous->string)
                {
                    if (aux_list->next->character == '('){
                        function_not_declarated (aux_list, fixed_header);
                    }
                }
            }
        }

        in_element = in_element->next;
    }
}
