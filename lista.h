#include <stdio.h>

#ifndef LISTA_H
#define LISTA_H

typedef struct List {
    char *predecessor;
    char *librarys;
    char *type;
    char *variable;
    char attribution; // =
    int value_int;
    float value_float;
    char *string;
    char init_inst;
    char end_inst;
    char coma;
    char init_brackets;
    char end_brackets;
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
