#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "otimizador.h"
#include "lista.h"
#include "variaveis.h"
#include "funcoes.h"

/*
Contar quantas vezes determinado item aparece no codigo, 
recebendo a cabeça da lista, além da variavel a ser contada, 
retornando assim o numero de vezes que a mesma aparece na lista.
*/
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

/*
Função para otimização do codido, a qual pode considerar variaveis ou funções não declaradas
*/
void optimize(header *fixed_header) {
    int i;
    list *in_element = fixed_header->head, *aux_list;

    //Percorre todos os elementos da lista.
    for(i = 0 ; i<fixed_header->n_elem ; i++)
    {
        if(in_element->string)
        {
            //Verifica os tipos de declarações
            aux_list = in_element;
            if(!strcmp(in_element->string, "char ") || !strcmp(in_element->string, "int ") 
               || !strcmp(in_element->string, "float ") || !strcmp(in_element->string, "\nchar ")
               || !strcmp(in_element->string, "\nint ") || !strcmp(in_element->string, "\nfloat "))
            {
/**************************************
    Variáveis não utilizadas
***************************************/
                //Após validar o tipo, percorrer as variaveis até encontrar um ';' indicando o final das declarações;
                for (aux_list = aux_list->next ; aux_list->character != ';' ; aux_list = aux_list->next)
                {
                    //Valida os itens para evitar uma falha de segmentação.
                    if(aux_list->string && aux_list->previous->string) 
                    {
                        //Verifica se o próximo elemento é uma string ou se é um caractere.
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
                            //Variavel no final das declarações.
                            if(!strcmp(aux_list->previous->string, ", ") && aux_list->next->character == ';')
                            {
                                variable_not_declarated_middle(aux_list, fixed_header);
                            }
                        }
                        //Variavel sozinha ou no inicio das declarações.
                        variable_not_declarated_alone(aux_list, fixed_header);
                    }
                }

/**************************************
    Funções não utilizadas
***************************************/
                if(in_element->next->next->character == '(' && strcmp(in_element->next->string, "main")) {
                    function_not_declarated(in_element, fixed_header);
                }
            }
        }
        in_element = in_element->next;
    }
}
