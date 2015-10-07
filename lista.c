#include "list.h"
#include <stdlib.h>
#include <string.h>

typedef struct List {
  char *predecessor;
  char **librarys;
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

header* initial_header() {
  header *init_header = (header*) malloc(sizeof(header));

  initial_header -> n_elem = 0;
  initial_header -> head = NULL;
  initial_header -> tail = NULL;

  return init_header;
}

list* initial_list(header *fixed_header) {

  list *init_list = (list*) malloc(sizeof(list));

  init_list -> predecessor = NULL;
  init_list -> librarys = NULL;
  init_list -> type = NULL;
  init_list -> variable = NULL;
  init_list -> attribution = '\0'; // =
  init_list -> value_int = -1;
  init_list -> value_float -1.0;
  init_list -> string = NULL;
  init_list -> init_inst = '\0';
  init_list -> end_inst = '\0';
  init_list -> coma = '\0';
  init_list -> init_brackets = '\0';
  init_list -> end_brackets = '\0';
  init_list -> previous = NULL;
  init_list -> next = NULL;

  return init_list;
}

void insert_elem(header *fixed_header, list *new_elem) {

  if(!fixed_header -> n_elem) {
    fixed_header -> head = new_elem;
    fixed_header -> tail = new_elem;
    fixed_header -> ++n_elem;
  }
  else {
    new_elem -> previous = fixed_header -> tail;
    new_elem -> next = fixed_header -> head;
    fixed_header -> tail -> next = new_elem;
    fixed_header -> head -> previous = new_elem;
    fixed_header -> ++n_elem;
  }
}
