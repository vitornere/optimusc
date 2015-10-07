#include <stdio.h>

#ifndef LISTA_H
#define LISTA_H

typedef struct List list;

typedef struct Header header;

header* initial_header();

list* initial_list(header *fixed_header);

void insert_elem(header *fixed_header, list *new_elem);

void print_list(header *fixed_header, FILE *file_end);

void free_list(header *fixed_header);

#endif
