#include "lista.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

header* initial_header() {
    header *init_header = (header*) malloc(sizeof(header));

    init_header -> n_elem = 0;
    init_header -> head = NULL;
    init_header -> tail = NULL;

    return init_header;
}

list* initial_list() {

    list *init_list = (list*) malloc(sizeof(list));

    init_list -> predecessor = NULL;
    init_list -> string = NULL;
    init_list -> character = '\0';
    init_list -> value_int = -1;
    init_list -> value_float = -1.0;
    init_list -> successor = NULL;
    init_list -> previous = NULL;
    init_list -> next = NULL;
    init_list -> amount_space = 0;

    return init_list;
}

void insert_elem(header *fixed_header, list *new_elem) {

    if(!fixed_header -> n_elem) {
        fixed_header -> head = new_elem;
        fixed_header -> tail = new_elem;
        new_elem -> next = new_elem -> previous = new_elem;
        fixed_header -> n_elem ++;
        printf("\nNum Elem: %d: ", fixed_header->n_elem);
        printf("\nNum Elem: %s\n", new_elem->string);
    }
    else {
        new_elem -> previous = fixed_header -> tail;
        new_elem -> next = fixed_header -> head;
        fixed_header -> tail -> next = new_elem;
        fixed_header -> head -> previous = new_elem;
        fixed_header -> tail = new_elem;
        fixed_header -> n_elem ++;
        printf("\nNum Elem: %d: \n", fixed_header->n_elem);
    }
}

void print_list(header *fixed_header, FILE *file_end) {
    int i;
    list *aux = fixed_header -> head;

    for(i=0; i<fixed_header->n_elem; i++)
    {
        if(aux -> predecessor)
        {
            fprintf(file_end, "%s", aux->predecessor);
        }

        if(aux -> string)
        {
            if(aux->amount_space){
                for(i = 0; i<aux->amount_space; i++) {
        			fprintf(file_end, "\t");
        		}
            }
            fprintf(file_end, "%s", aux->string);
        }

        if(aux -> character != '\0') {

            if(aux->amount_space){
                for(i = 0; i<aux->amount_space; i++) {
        			fprintf(file_end, "\t");
        		}
            }

            if(aux->character == '{') {

            }
            fprintf(file_end, "%c ", aux->character);

            if(aux->character == ';' || aux->character == '{') {
                fprintf(file_end, "\n");
            }
        }

        if(aux -> value_int != -1) {
            if(aux->amount_space){
                for(i = 0; i<aux->amount_space; i++) {
        			fprintf(file_end, "\t");
        		}
            }
            fprintf(file_end, "%d", aux->value_int);
        }

        if(aux -> value_float != -1.0) {
            if(aux->amount_space){
                for(i = 0; i<aux->amount_space; i++) {
        			fprintf(file_end, "\t");
        		}
            }
            fprintf(file_end, "%f", aux->value_float);
        }

        if(aux->successor) {
            fprintf(file_end, "%s", aux->successor);
        }

        aux = aux -> next;
    }
}

void free_list(header *fixed_header) {
    list *aux, *next_aux = fixed_header->head;
    int i;

    for(i=0; i < fixed_header->n_elem; i++)
    {
        aux = next_aux;
        next_aux = next_aux -> next;
        free(aux);
    }

    free(fixed_header);
}

char* aloc_string(char *string) {
    char *new_string = (char*) malloc(sizeof(char)*strlen(string));

	strcpy(new_string, string);

	return new_string;
}
