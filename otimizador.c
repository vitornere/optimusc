#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "otimizador.h"
#include "lista.h"
#include "variaveis.h"
#include "funcoes.h"

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

void optimize(header *fixed_header) {
    int i;
    list *in_element = fixed_header->head, *aux_list;

    for(i = 0 ; i<fixed_header->n_elem ; i++)
    {
        if(in_element->string)
        {
            aux_list = in_element;
            if(!strcmp(in_element->string, "char ") || !strcmp(in_element->string, "int ") || !strcmp(in_element->string, "float ")) 
            {
                for (aux_list = aux_list->next ; aux_list->character != ';' ; aux_list = aux_list->next)
                {
                    if(aux_list->string && aux_list->previous->string) 
                    {
                        if(aux_list->next->string) 
                        {
                            if(!strcmp(aux_list->previous->string, ", ") && !strcmp(aux_list->next->string,", ")) 
                            {
                                variable_not_declarated_middle(aux_list, fixed_header);
                            }
                            else if (!strcmp(aux_list->previous->string, ", ") && !strcmp(aux_list->next->string," = ")) 
                            {
                                variable_not_declarated_equals(aux_list, fixed_header);
                            }
                        }
                        else if(aux_list->next->character)
                        {
                            if(!strcmp(aux_list->previous->string, ", ") && aux_list->next->character == ';')
                            {
                                variable_not_declarated_middle(aux_list, fixed_header);
                            }
                        }
                        variable_not_declarated_alone(aux_list, fixed_header);
                    }
                }
            }
        }
        in_element = in_element->next;
    }
}
