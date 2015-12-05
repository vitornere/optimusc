#include <stdio.h>
#include "lista.h"

#ifndef LISTA_H
#define LISTA_H

int how_many_times(header *fixed_header, list *variable);
void variable_not_declarated_alone(list *in_element, header *fixed_header);
void variable_not_declarated_middle(list *in_element, header *fixed_header);
void variable_not_declarated_equals(list *in_element, header *fixed_header);

#endif