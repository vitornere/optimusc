%{
#include <stdio.h>
#include "sintatico.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%token TK_RE_INT
%token TK_RE_FLOAT
%token TK_RE_CHAR
%token TK_RE_STRING
%token TK_VALUE_INT
%token TK_VALUE_FLOAT
%token TK_VALUE_CHAR
%token TK_VALUE_STRING
%token TK_VARIABLE
%token TK_END_INST_LINE
%token TK_INIT_INST
%token TK_END_INST
%token TK_ATTRIBUITION
%token TK_TYPE
%start start

%union {
    int     number_int;
    float   number_float;
    char    caracter;
    char*   string;
    char*	variable;
    char*	type;

}

%%

start:
	TK_END_INST
	| int_attribuited
;

int_attribuited:
	TK_RE_INT TK_VARIABLE TK_ATTRIBUITION TK_VALUE_INT TK_END_INST_LINE { }
	| int_only_declarated
;

int_only_declarated:
	TK_RE_INT TK_VARIABLE TK_END_INST_LINE { }
	| init_inst
;

init_inst:
	TK_INIT_INST { }
;

%%

int yywrap() { return 1; }