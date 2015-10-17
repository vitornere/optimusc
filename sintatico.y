%{
#include <stdio.h>
#include "sintatico.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE* yyout;

int amount_space = 0, i, open_file = 0;
char const tab[4] = "    ";
%}

%token TK_RE_INT
%token TK_RE_FLOAT
%token TK_RE_CHAR
%token TK_RE_STRING
%token TK_RE_RETURN
%token TK_RE_ELSE
%token TK_RE_IF
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
%token TK_AND
%token TK_OR
%token TK_ATTRIBUITION
%token TK_COMPARISON_LT /*Less than  '<' */
%token TK_COMPARISON_GT /*Greater than '>' */
%token TK_COMPARISON_ET /*Equal to '==' */
%token TK_COMPARISON_DT /*Different than '!=' */
%token <string> TK_LIBRARY

%start start

%union {
    int     number_int;
    float   number_float;
    char    caracter;
    char*   string;
}

%%

/**********************/
/*  Análise Sintática */
/**********************/

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
	| float_attribuited
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
	| conditional_elif
;

condition_valid_values:
	TK_VALUE_INT
	|TK_VALUE_CHAR
	|TK_VALUE_FLOAT
	|TK_VALUE_STRING
	|TK_VARIABLE
;

condition_comparator:
	TK_COMPARISON_DT
	|TK_COMPARISON_ET
	|TK_COMPARISON_GT
	|TK_COMPARISON_LT
;

valid_condition:
	condition_valid_values condition_comparator condition_valid_values
;

condition_expression:
	valid_condition TK_AND condition_expression
	|valid_condition TK_OR condition_expression
	|valid_condition
;

conditional_elif:
	TK_RE_ELSE TK_RE_IF TK_INIT_BRACKETS TK_VALUE_INT TK_END_BRACKETS TK_INIT_INST start 
	| TK_RE_ELSE TK_RE_IF TK_INIT_BRACKETS condition_expression TK_END_BRACKETS TK_INIT_INST start 
	| conditional_else 
;

conditional_else:
	TK_RE_ELSE TK_INIT_INST start 
	| conditional_if
;

conditional_if:
	TK_RE_IF TK_INIT_BRACKETS TK_VALUE_INT TK_END_BRACKETS TK_INIT_INST start 
	| TK_RE_IF TK_INIT_BRACKETS condition_expression TK_END_BRACKETS TK_INIT_INST start 
	| declarated_library 
;


declarated_library:
	TK_LIBRARY
	{
		if(!open_file)
		{
			yyout = fopen("saida.txt", "w");
			open_file = 1;
		}

		fprintf(yyout, "%s\n", $1);
	}
;

/**********************/
/*  Análise Sintática */
/**********************/


/**********************/
/*  Boas Práticas */
/**********************/

/**********************/
/*  Análise Sintática */
/**********************/


/**********************/
/*    Impressão .c    */
/**********************/

/**********************/
/*    Impressão .c    */
/**********************/

%%

int yywrap() { return 1; }
