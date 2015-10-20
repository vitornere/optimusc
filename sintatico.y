%{
#include "sintatico.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lista.h"

extern FILE* yyout;
header *fixed_header;
list *current_list;

int amount_space = 0, i, started_header = 0, end_file = 0;
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
%token TK_PLUS
%token TK_MINUS
%token TK_TIMES
%token TK_DIVI

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
        amount_space--;
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("}\n");
        current_list -> amount_space = amount_space;
        insert_elem(fixed_header, current_list);

        end_file --;
        printf("\n\nend_file: %d\n\n", end_file);

        if(!end_file) {
            /**********************/
            /*    Boas Práticas   */
            /**********************/

            /**********************/
            /*    Boas Práticas   */
            /**********************/

            /**********************/
            /*    Impressão .c    */
            /**********************/
                    yyout = fopen("saida.c", "w");
                    printf("\n%d\n", end_file);
                    if(!yyout) {
                        printf("\n Falha ao abrir o arquivo\n");
                        exit(1);
                    }
                    print_list(fixed_header, yyout);
                    fclose(yyout);

                    free_list(fixed_header);
            /**********************/
            /*    Impressão .c    */
            /**********************/
        }
	}
	| int_function start
;

atribution_int:
	TK_RE_INT  TK_VARIABLE TK_COMA atribution_int
	{
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("int ");
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string($2);
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(", ");
        insert_elem(fixed_header, current_list);
	}
	| TK_RE_INT TK_VARIABLE
	{
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("int ");
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string($2);
        insert_elem(fixed_header, current_list);
	}
;

int_function:
	TK_RE_INT TK_VARIABLE TK_INIT_BRACKETS
	{
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("\nint ");
        current_list -> amount_space = amount_space;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string($2);
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = '(';
        insert_elem(fixed_header, current_list);
	}
	atribution_int TK_END_BRACKETS TK_INIT_INST
	{
        current_list = NULL;
        current_list = initial_list();
        current_list -> character = ')';
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" {\n\n");
        ++amount_space;
        insert_elem(fixed_header, current_list);

        end_file++;
        printf("\n\nend_file: %d\n\n", end_file);
	}
	| TK_RE_INT TK_VARIABLE TK_INIT_BRACKETS TK_END_BRACKETS TK_INIT_INST
	{
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("\nint ");
        current_list -> amount_space = amount_space;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string($2);
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = '(';
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = ')';
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" {\n\n");
        ++amount_space;
        insert_elem(fixed_header, current_list);

        end_file++;
        printf("\n\nend_file: %d\n\n", end_file);
	}
	| expression_final
;

expression_final:
	TK_VARIABLE TK_ATTRIBUITION
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string($1);
        current_list -> amount_space = amount_space;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" = ");
        insert_elem(fixed_header, current_list);
    }
    expression TK_END_INST_LINE
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> character = ';';
        insert_elem(fixed_header, current_list);
    }
	| float_attribuited
;

value:
	TK_VALUE_INT
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> value_int = $1;
        current_list -> amount_space = amount_space;
        insert_elem(fixed_header, current_list);
    }
	| TK_VALUE_FLOAT
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> value_float = $1;
        current_list -> amount_space = amount_space;
        insert_elem(fixed_header, current_list);
    }
	| TK_VARIABLE
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string($1);
        insert_elem(fixed_header, current_list);
    }
;

aritmetcs:
	TK_PLUS
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" + ");
        insert_elem(fixed_header, current_list);
    }
	| TK_MINUS
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" - ");
        insert_elem(fixed_header, current_list);
    }
	| TK_TIMES
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" * ");
        insert_elem(fixed_header, current_list);
    }
	| TK_DIVI
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" / ");
        insert_elem(fixed_header, current_list);
    }
;

expression:
    TK_INIT_BRACKETS
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> character = '(';
        insert_elem(fixed_header, current_list);
    }
    expression TK_END_BRACKETS
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> character = ')';
        insert_elem(fixed_header, current_list);
    }
    | expression aritmetcs expression
	| value
;

float_attribuited:
	TK_RE_FLOAT TK_VARIABLE TK_ATTRIBUITION TK_VALUE_FLOAT TK_END_INST_LINE
	{
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("float ");
        current_list -> amount_space = amount_space;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string($2);
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" = ");
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> value_float = $4;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = ';';
        insert_elem(fixed_header, current_list);
	}
	| float_only_declarated
;

float_only_declarated:
	TK_RE_FLOAT TK_VARIABLE TK_END_INST_LINE
	{
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("float ");
        current_list -> amount_space = amount_space;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string($2);
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = ';';
        insert_elem(fixed_header, current_list);
	}
	| int_attribuited
;

int_attribuited:
	TK_RE_INT TK_VARIABLE TK_ATTRIBUITION TK_VALUE_INT TK_END_INST_LINE
	{
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("int ");
        current_list -> amount_space = amount_space;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string($2);
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" = ");
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> value_int = $4;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = ';';
        insert_elem(fixed_header, current_list);
	}
	| int_only_declarated
;

int_only_declarated:
	TK_RE_INT TK_VARIABLE TK_END_INST_LINE
	{
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("int ");
        current_list -> amount_space = amount_space;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string($2);
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = ';';
        insert_elem(fixed_header, current_list);
	}
	| char_attribuited
;

char_attribuited:
    TK_RE_CHAR TK_VARIABLE TK_ATTRIBUITION TK_VALUE_CHAR TK_END_INST_LINE
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("char ");
        current_list -> amount_space = amount_space;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string($2);
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" = ");
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = '\'';
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = $4;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = '\'';
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = ';';
        insert_elem(fixed_header, current_list);
	}
    | char_only_declarated
;

char_only_declarated:
    TK_RE_CHAR TK_VARIABLE TK_END_INST_LINE
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("char ");
        current_list -> amount_space = amount_space;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = $2;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = ';';
        insert_elem(fixed_header, current_list);
	}
	| return_declared_int
;

return_declared_int:
	TK_RE_RETURN TK_VALUE_INT TK_END_INST_LINE
	{
		/* fprintf(yyout, "\nreturn %d;\n", $2); */

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("\nreturn ");
        current_list -> amount_space = --amount_space;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> value_int = $2;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = ';';
        insert_elem(fixed_header, current_list);
	}
	| conditional_elif
;

condition_comparator:
	TK_COMPARISON_DT
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" != ");
        insert_elem(fixed_header, current_list);
    }
	| TK_COMPARISON_ET
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" == ");
        insert_elem(fixed_header, current_list);
    }
	| TK_COMPARISON_GT
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" > ");
        insert_elem(fixed_header, current_list);
    }
	| TK_COMPARISON_LT
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" < ");
        insert_elem(fixed_header, current_list);
    }
;

valid_condition:
     expression condition_comparator expression
;

condition_expression:
	valid_condition TK_AND
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" && ");
        insert_elem(fixed_header, current_list);
    }
    condition_expression
	| valid_condition TK_OR
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" || ");
        insert_elem(fixed_header, current_list);
    }
    condition_expression
	| valid_condition
;

conditional_elif:
	TK_RE_ELSE TK_RE_IF TK_INIT_BRACKETS TK_VALUE_INT TK_END_BRACKETS TK_INIT_INST
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("else ");
        current_list -> amount_space = amount_space;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("if");
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = '(';
        current_list -> id = 1;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> value_int = $4;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = ')';
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" {\n");
        ++amount_space;
        insert_elem(fixed_header, current_list);

        end_file++;
        printf("\n\nend_file: %d\n\n", end_file);
    }
    start
	| TK_RE_ELSE TK_RE_IF TK_INIT_BRACKETS
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("else ");
        current_list -> amount_space = amount_space;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("if");
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = '(';
        current_list -> id = 1;
        insert_elem(fixed_header, current_list);
    }
    condition_expression TK_END_BRACKETS TK_INIT_INST
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> character = ')';
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" {\n");
        ++amount_space;
        insert_elem(fixed_header, current_list);

        end_file++;
        printf("\n\nend_file: %d\n\n", end_file);
    }
    start
	| conditional_else
;

conditional_else:
	TK_RE_ELSE TK_INIT_INST
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("else");
        current_list -> amount_space = amount_space;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" {\n");
        ++amount_space;
        insert_elem(fixed_header, current_list);

        end_file++;
        printf("\n\nend_file: %d\n\n", end_file);
    }
    start
	| conditional_if
;

conditional_if:
	TK_RE_IF TK_INIT_BRACKETS TK_VALUE_INT TK_END_BRACKETS TK_INIT_INST
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("if");
        current_list -> amount_space = amount_space;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = '(';
        current_list -> id = 1;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> value_int = $3;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = ')';
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" {\n");
        ++amount_space;
        insert_elem(fixed_header, current_list);

        end_file++;
        printf("\n\nend_file: %d\n\n", end_file);
    }
    start
	| TK_RE_IF TK_INIT_BRACKETS
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string("if");
        current_list -> amount_space = amount_space;
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> character = '(';
        current_list -> id = 1;
        insert_elem(fixed_header, current_list);
    }
    condition_expression TK_END_BRACKETS TK_INIT_INST
    {
        current_list = NULL;
        current_list = initial_list();
        current_list -> character = ')';
        insert_elem(fixed_header, current_list);

        current_list = NULL;
        current_list = initial_list();
        current_list -> string = aloc_string(" {\n");
        ++amount_space;
        insert_elem(fixed_header, current_list);

        end_file++;
        printf("\n\nend_file: %d\n\n", end_file);
    }
    start
	| declarated_library
;


declarated_library:
	TK_LIBRARY
	{
		if(!started_header)
		{
            fixed_header = initial_header();
            current_list = initial_list();
            current_list -> string = aloc_string($1);
            current_list -> successor = aloc_string("\n");
            insert_elem(fixed_header, current_list);
			started_header = 1;
		}
		else {
			current_list = NULL;
			current_list = initial_list();
			current_list -> string = aloc_string($1);
            current_list -> successor = aloc_string("\n");
			insert_elem(fixed_header, current_list);
		}
	}
;

/**********************/
/*  Análise Sintática */
/**********************/

%%

int yywrap() { return 1; }
