%{
#include "sintatico.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lista.h"

extern FILE* yyout;
header *fixed_header;
list *current_list;

int amount_space = 0, i, started_header = 0;
char const tab[4] = "    ";
%}

%token TK_RE_INT
%token TK_RE_FLOAT
%token TK_RE_CHAR
%token TK_RE_STRING
%token TK_RE_RETURN
%token <number_int> TK_VALUE_INT
%token <number_float> TK_VALUE_FLOAT
%token <caracter> TK_VALUE_CHAR
%token <string> TK_VALUE_STRING
%token <string> TK_VARIABLE
%token TK_END_INST_LINE
%token TK_INIT_INST
%token TK_END_INST
%token TK_INIT_BRACKETS
%token TK_END_BRACKETS
%token TK_COMA
%token TK_ATTRIBUITION
%token <string> TK_LIBRARY
%left TK_PLUS
%left TK_MINUS
%left TK_TIMES
%left TK_DIVI

%start start

%union {
    int     number_int;
    float   number_float;
    char    caracter;
    char*   string;
}

%%

start:
	TK_END_INST
	{
		fprintf(yyout, "}");
	}
	| int_function start
;

atribution_int:
	TK_RE_INT  TK_VARIABLE TK_COMA atribution_int
	{
		fprintf(yyout, "int %s, ", $2);
	}
	| TK_RE_INT TK_VARIABLE
	{
		fprintf(yyout, "int %s", $2);
	}
;

int_function:
	TK_RE_INT TK_VARIABLE TK_INIT_BRACKETS
	{
		fprintf(yyout, "\n");

		for(i = 0; i<amount_space; i++) {
			fprintf(yyout, "\t");
		}

		fprintf(yyout, "int %s(", $2);
	}
	atribution_int TK_END_BRACKETS TK_INIT_INST
	{
		fprintf(yyout, ") {\n");
		amount_space++;
	}
	| TK_RE_INT TK_VARIABLE TK_INIT_BRACKETS TK_END_BRACKETS TK_INIT_INST
	{
		fprintf(yyout, "\n");

		for(i = 0; i<amount_space; i++) {
			fprintf(yyout, "\t");
		}

		fprintf(yyout, "int %s() {\n", $2);
		amount_space++;
	}
	| expression_final
;

expression_final:
	expression TK_END_INST_LINE
	| float_attribuited
;

value:
	TK_VALUE_INT
	| TK_VALUE_FLOAT
	| TK_VARIABLE
;

aritmetcs:
	TK_PLUS
	| TK_MINUS
	| TK_TIMES
	| TK_DIVI
;

expression:
	value
	| expression aritmetcs expression
	| TK_INIT_BRACKETS expression TK_END_BRACKETS
;

float_attribuited:
	TK_RE_FLOAT TK_VARIABLE TK_ATTRIBUITION TK_VALUE_FLOAT TK_END_INST_LINE
	{
		for(i = 0; i<amount_space; i++) {
			fprintf(yyout, "\t");
		}

		fprintf(yyout, "float %s = %f;\n", $2, $4);
	}
	| float_only_declarated
;

float_only_declarated:
	TK_RE_FLOAT TK_VARIABLE TK_END_INST_LINE
	{
		for(i = 0; i<amount_space; i++) {
			fprintf(yyout, "\t");
		}

		fprintf(yyout, "float %s;\n", $2);
	}
	| int_attribuited
;

int_attribuited:
	TK_RE_INT TK_VARIABLE TK_ATTRIBUITION TK_VALUE_INT TK_END_INST_LINE
	{
		for(i = 0; i<amount_space; i++) {
			fprintf(yyout, "\t");
		}

		fprintf(yyout, "int %s = %d;\n", $2, $4);
	}
	| int_only_declarated
;

int_only_declarated:
	TK_RE_INT TK_VARIABLE TK_END_INST_LINE
	{
		for(i = 0; i<amount_space; i++) {
			fprintf(yyout, "\t");
		}

		fprintf(yyout, "int %s;\n", $2);
	}
	| char_attribuited
;

char_attribuited:
    TK_RE_CHAR TK_VARIABLE TK_ATTRIBUITION TK_VALUE_CHAR TK_END_INST_LINE
    {
		for(i = 0; i<amount_space; i++) {
			fprintf(yyout, "\t");
		}

		fprintf(yyout, "char %s = '%c';\n", $2, $4);
	}
    | char_only_declarated
;

char_only_declarated:
    TK_RE_CHAR TK_VARIABLE TK_END_INST_LINE
    {
		for(i = 0; i<amount_space; i++) {
			fprintf(yyout, "\t");
		}

		fprintf(yyout, "char %s;\n", $2);
	}
	| return_declared_int
;

return_declared_int:
	TK_RE_RETURN TK_VALUE_INT TK_END_INST_LINE
	{
		fprintf(yyout, "\nreturn %d;\n", $2);
	}
	| declarated_library
;

declarated_library:
	TK_LIBRARY
	{
		if(!started_header)
		{
            fixed_header = initial_header();
            current_list = initial_list();
            current_list -> librarys = aloc_string($1);
            insert_elem(fixed_header, current_list);
			started_header = 1;
		}
		else {
			current_list = NULL;
			current_list = initial_list();
			current_list -> librarys = aloc_string($1);
			insert_elem(fixed_header, current_list);
		}
	}
;



%%

int yywrap() { return 1; }