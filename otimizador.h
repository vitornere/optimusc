#include <stdio.h>
#include "lista.h"

#ifndef LISTA_H
#define LISTA_H

int how_many_times(header *fixed_header, list *variable);
void variable_not_declarated(list *in_element, header *fixed_header);
void optimize(header *fixed_header);

#endif