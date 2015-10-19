#include <stdio.h>

#ifndef LISTA_H
#define LISTA_H

typedef struct List {
    char *predecessor;
    char *string;
    char character;
    int value_int;
    float value_float;
    char *successor;
    int amount_space;

    struct List *previous;
    struct List *next;
} list;

typedef struct Header {
    int n_elem;
    struct List *head;
    struct List *tail;
} header;

header* initial_header();

list* initial_list();

void insert_elem(header *fixed_header, list *new_elem);

void print_list(header *fixed_header, FILE *file_end);

void free_list(header *fixed_header);

char* aloc_string(char *string);

#endif
