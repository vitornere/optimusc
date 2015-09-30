%{
#include <stdio.h>
#include "sintatico.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%token <int_val> TK_RE_INT
%token <int_val> TK_RE_FLOAT
%token <int_val> TK_RE_CHAR
%token <int_val> TK_RE_STRING
%token <int_val> TK_VALUE_INT
%token <float_val> TK_VALUE_FLOAT
%token <char_val> TK_VALUE_CHAR
%token <char*_val> TK_VALUE_STRING
%token <char*_val> TK_VARIABLE
%token <int_val> TK_END_INST_LINE
%token <int_val> TK_INIT_INST
%token <int_val> TK_END_INST
%token <int_val> TK_ATTRIBUITION
%token <char*_val> TK_TYPE
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
	TK_END_INST {  }
	| int_attribuited start
;

int_attribuited:
	TK_RE_INT TK_VARIABLE TK_ATTRIBUITION TK_VALUE_INT TK_END_INST_LINE {  }
	| int_only_declarated
;

int_only_declarated:
	TK_RE_INT TK_VARIABLE TK_END_INST_LINE
	| char_attribuited
;

char_attribuited:
    TK_RE_CHAR TK_VARIABLE TK_ATTRIBUITION TK_VALUE_CHAR TK_END_INST_LINE {  }
    | char_only_declarated
;

char_only_declarated:
    TK_RE_CHAR TK_VARIABLE TK_END_INST_LINE {  }
    | init_inst
;

init_inst:
	TK_INIT_INST { }
;
%%

int yywrap() { return 1; }