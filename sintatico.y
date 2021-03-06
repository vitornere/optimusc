%{
#include "sintatico.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lista.h"
#include "otimizador.h"

extern FILE* yyout;
header *fixed_header;
list *current_list;

int amount_space = 0, i, started_header = 0;
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
%token END

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
	END
	{
			/**********************/
            /*    Boas Práticas   */
            /**********************/

                    optimize(fixed_header);

            /**********************/
            /*    Boas Práticas   */
            /**********************/

            /**********************/
            /*    Impressão .c    */
            /**********************/
                    yyout = fopen("saida.c", "w");
                    if(!yyout) {
                        printf("\n Falha ao abrir o arquivo\n");
                        exit(1);
                    }
                    print_list(fixed_header, yyout);
                    fclose(yyout);

                    free_list(fixed_header);
                    printf("Compilação bem sucedida!!!\n\n");
                    exit(0);
            /**********************/
            /*    Impressão .c    */
            /**********************/
	}
	|
	TK_END_INST
	{
        amount_space--;
        update_list_string_with_space(fixed_header, "}\n", amount_space);
	} start
	| int_function start
;

variable_types:
	TK_RE_INT
	{
		update_list_string(fixed_header, "int ");
	}
	| TK_RE_FLOAT
	{
		update_list_string(fixed_header, "float ");
	}
	| TK_RE_CHAR
	{
		update_list_string(fixed_header, "char ");
	}
;
atributions:
	variable_types TK_VARIABLE TK_COMA
	{
		update_list_string(fixed_header, $2);
		update_list_string(fixed_header, ", ");
	} atributions
	| variable_types TK_VARIABLE
	{
		update_list_string(fixed_header, $2);
	}
;

int_function:
	TK_RE_INT  TK_VARIABLE TK_INIT_BRACKETS
	{
		update_list_string_with_space(fixed_header, "\nint ",amount_space);
		update_list_string(fixed_header, $2);
		update_list_character(fixed_header, '(');
	}
	atributions TK_END_BRACKETS TK_INIT_INST
	{
		update_list_character(fixed_header, ')');
		update_list_string(fixed_header," {\n\n");

        ++amount_space;
	}
	| TK_RE_INT TK_VARIABLE TK_INIT_BRACKETS TK_END_BRACKETS TK_INIT_INST
	{
		update_list_string_with_space(fixed_header,"\nint ", amount_space);
		update_list_string(fixed_header, $2);

		update_list_character(fixed_header, '(');
		update_list_character(fixed_header, ')');

		update_list_string(fixed_header, " {\n\n");

        ++amount_space;
	}
	| float_function
;

float_function:
	TK_RE_FLOAT  TK_VARIABLE TK_INIT_BRACKETS
	{
		update_list_string_with_space(fixed_header, "\nfloat ",amount_space);
		update_list_string(fixed_header, $2);
		update_list_character(fixed_header, '(');
	}
	atributions TK_END_BRACKETS TK_INIT_INST
	{
		update_list_character(fixed_header, ')');
		update_list_string(fixed_header," {\n\n");

        ++amount_space;
	}
	| TK_RE_FLOAT TK_VARIABLE TK_INIT_BRACKETS TK_END_BRACKETS TK_INIT_INST
	{
		update_list_string_with_space(fixed_header,"\nint ", amount_space);
		update_list_string(fixed_header, $2);

		update_list_character(fixed_header, '(');
		update_list_character(fixed_header, ')');

		update_list_string(fixed_header, " {\n\n");

        ++amount_space;
	}
	| char_function
;

char_function:
	TK_RE_CHAR TK_VARIABLE TK_INIT_BRACKETS
	{
		update_list_string_with_space(fixed_header, "\nchar ",amount_space);
		update_list_string(fixed_header, $2);
		update_list_character(fixed_header, '(');
	}
	atributions TK_END_BRACKETS TK_INIT_INST
	{
		update_list_character(fixed_header, ')');
		update_list_string(fixed_header," {\n\n");

        ++amount_space;
	}
	| TK_RE_CHAR TK_VARIABLE TK_INIT_BRACKETS TK_END_BRACKETS TK_INIT_INST
	{
		update_list_string_with_space(fixed_header,"\nint ", amount_space);
		update_list_string(fixed_header, $2);

		update_list_character(fixed_header, '(');
		update_list_character(fixed_header, ')');

		update_list_string(fixed_header, " {\n\n");

        ++amount_space;
	}
	| expression_final
;
expression_final:
	TK_VARIABLE TK_ATTRIBUITION
    {
		update_list_string_with_space(fixed_header,$1, amount_space);
		update_list_string(fixed_header, " = ");
    }
    expression TK_END_INST_LINE
    {
   		update_list_character(fixed_header, ';');
    }
	| function_declared
;

value_atriibuted:
	value TK_COMA
	{
		update_list_string(fixed_header, ", ");
	} 
	value_atriibuted
	| value

;

value:
	TK_VALUE_INT
    {
    	update_list_int_with_space(fixed_header, $1, amount_space);
    }
	| TK_VALUE_FLOAT
    {
    	update_list_float_with_space(fixed_header, $1, amount_space);
    }
    | TK_VALUE_STRING
    {
    	update_list_string_with_space(fixed_header, $1, amount_space);
    }
	| TK_VARIABLE
    {
		update_list_string(fixed_header, $1);
    }
;

function_declared:
	TK_VARIABLE TK_INIT_BRACKETS
	{
		update_list_string_with_space(fixed_header, $1, amount_space);
		update_list_character(fixed_header, '(');
	}
	value_atriibuted TK_END_BRACKETS TK_END_INST_LINE
	{
		update_list_character(fixed_header, ')');
		update_list_character(fixed_header, ';');
	}
	|TK_VARIABLE TK_INIT_BRACKETS TK_END_BRACKETS TK_END_INST_LINE
	{
		update_list_string_with_space(fixed_header, $1, amount_space);
		update_list_character(fixed_header, '(');
		update_list_character(fixed_header, ')');
		update_list_character(fixed_header, ';');
	}
	| float_attribuited
;

aritmetcs:
	TK_PLUS
    {
		update_list_string(fixed_header, " + ");
    }
	| TK_MINUS
    {
		update_list_string(fixed_header, " - ");
    }
	| TK_TIMES
    {
		update_list_string(fixed_header, " * ");
    }
	| TK_DIVI
    {
		update_list_string(fixed_header, " / ");
    }
;

expression:
    TK_INIT_BRACKETS
    {
   		update_list_character(fixed_header, '(');
    }
    expression TK_END_BRACKETS
    {
   		update_list_character(fixed_header, ')');
    }
    | expression aritmetcs expression
	| value
;

float_attribuited:
	TK_RE_FLOAT TK_VARIABLE TK_ATTRIBUITION TK_VALUE_FLOAT
	{
		update_list_string_with_space(fixed_header,"float ",amount_space);

		update_list_string(fixed_header, $2);
		update_list_string(fixed_header, " = ");

		update_list_float(fixed_header, $4);

	}
	float_attribuited
	| TK_COMA TK_VARIABLE TK_ATTRIBUITION TK_VALUE_FLOAT
	{
		update_list_string(fixed_header, ", ");
		update_list_string(fixed_header, $2);
		update_list_string(fixed_header, " = ");

        update_list_float(fixed_header, $4);
	}
	float_attribuited
	| float_only_declarated
;

float_only_declarated:
	TK_RE_FLOAT TK_VARIABLE
	{
		update_list_string_with_space(fixed_header,"float ",amount_space);

		update_list_string(fixed_header, $2);

	}
	float_attribuited
	| TK_COMA TK_VARIABLE
	{
		update_list_string(fixed_header, ", ");
		update_list_string(fixed_header, $2);
	}
	float_attribuited
	| TK_END_INST_LINE
	{
		update_list_character(fixed_header, ';');
	}
	| int_attribuited
;

int_attribuited:
	TK_RE_INT TK_VARIABLE TK_ATTRIBUITION TK_VALUE_INT
	{
		update_list_string_with_space(fixed_header,"int ",amount_space);
		update_list_string(fixed_header, $2);
		update_list_string(fixed_header, " = ");
		update_list_int(fixed_header, $4);
	}
	int_attribuited
	| TK_COMA TK_VARIABLE TK_ATTRIBUITION TK_VALUE_INT
	{
		update_list_string(fixed_header, ", ");
		update_list_string(fixed_header, $2);
		update_list_string(fixed_header, " = ");
		update_list_int(fixed_header, $4);
	}
	int_attribuited
	| int_only_declarated
;

int_only_declarated:
	TK_RE_INT TK_VARIABLE
	{
		update_list_string_with_space(fixed_header,"int ",amount_space);

		update_list_string(fixed_header, $2);
	}
	int_attribuited
	| TK_COMA TK_VARIABLE
	{
		update_list_string(fixed_header, ", ");
		update_list_string(fixed_header, $2);
	}
	int_attribuited
	| TK_END_INST_LINE
	{
		update_list_character(fixed_header, ';');
	}
	| char_attribuited
;

char_attribuited:
    TK_RE_CHAR TK_VARIABLE TK_ATTRIBUITION TK_VALUE_CHAR
    {
    	update_list_string_with_space(fixed_header,"char ",amount_space);
		update_list_string(fixed_header, $2);
		update_list_string(fixed_header, " = ");

   		update_list_character(fixed_header, '\'');
   		update_list_character(fixed_header, $4);
   		update_list_character(fixed_header, '\'');
	}
	char_attribuited
	| TK_COMA TK_VARIABLE TK_ATTRIBUITION TK_VALUE_CHAR
	{
		update_list_string(fixed_header, ", ");
		update_list_string(fixed_header, $2);
		update_list_string(fixed_header, " = ");

   		update_list_character(fixed_header, '\'');
   		update_list_character(fixed_header, $4);
   		update_list_character(fixed_header, '\'');
	}
    | char_only_declarated
;

char_only_declarated:
    TK_RE_CHAR TK_VARIABLE
    {
		update_list_string_with_space(fixed_header,"char ",amount_space);

		update_list_string(fixed_header, $2);
	}
	char_attribuited
	| TK_COMA TK_VARIABLE
	{
		update_list_string(fixed_header, ", ");
		update_list_string(fixed_header, $2);
	}
	char_attribuited
	| TK_END_INST_LINE
	{
   		update_list_character(fixed_header, ';');
	}
	| return_declared_int
;


return_declared_int:
	TK_RE_RETURN TK_VALUE_INT TK_END_INST_LINE
	{
		update_list_string_with_space(fixed_header,"\nreturn ",amount_space);

		update_list_int(fixed_header, $2);

   		update_list_character(fixed_header, ';');
	}
	| conditional_elif
;

condition_comparator:
	TK_COMPARISON_DT
    {
    	update_list_string(fixed_header, " != ");
    }
	| TK_COMPARISON_ET
    {
    	update_list_string(fixed_header, " == ");
    }
	| TK_COMPARISON_GT
    {
    	update_list_string(fixed_header, " > ");
    }
	| TK_COMPARISON_LT
    {
    	update_list_string(fixed_header, " < ");
    }
;

valid_condition:
     expression condition_comparator expression
;

condition_expression:
	valid_condition TK_AND
    {
		update_list_string(fixed_header, " && ");
    }
    condition_expression
	| valid_condition TK_OR
    {
    	update_list_string(fixed_header, " || ");
    }
    condition_expression
	| valid_condition
;

conditional_elif:
	TK_RE_ELSE TK_RE_IF TK_INIT_BRACKETS TK_VALUE_INT TK_END_BRACKETS TK_INIT_INST
    {
		update_list_string_with_space(fixed_header,"else ",amount_space);

		update_list_string(fixed_header, "if");

		update_list_character(fixed_header,'(');

		update_list_int(fixed_header, $4);

   		update_list_character(fixed_header, ')');

   		update_list_string(fixed_header, " {\n");

        ++amount_space;
    }
    start
	| TK_RE_ELSE TK_RE_IF TK_INIT_BRACKETS
    {
		update_list_string_with_space(fixed_header,"else ",amount_space);

		update_list_string(fixed_header, "if");

		update_list_character(fixed_header, '(');

    }
    condition_expression TK_END_BRACKETS TK_INIT_INST
    {
   		update_list_character(fixed_header, ')');

		update_list_string(fixed_header, " {\n");

        ++amount_space;
    }
    start
	| conditional_else
;

conditional_else:
	TK_RE_ELSE TK_INIT_INST
    {
		update_list_string_with_space(fixed_header,"else",amount_space);

		update_list_string(fixed_header," {\n");

        ++amount_space;
    }
    start
	| conditional_if
;

conditional_if:
	TK_RE_IF TK_INIT_BRACKETS TK_VALUE_INT TK_END_BRACKETS TK_INIT_INST
    {
		update_list_string_with_space(fixed_header,"if",amount_space);

		update_list_character(fixed_header, '(');

		update_list_int(fixed_header, $3);

   		update_list_character(fixed_header, ')');

   		update_list_string(fixed_header, " {\n");

        ++amount_space;
    }
    start
	| TK_RE_IF TK_INIT_BRACKETS
    {
   		update_list_string_with_space(fixed_header, "if",amount_space);

   		update_list_character(fixed_header, '(');
    }
    condition_expression TK_END_BRACKETS TK_INIT_INST
    {
    	update_list_character(fixed_header, ')');

   		update_list_string(fixed_header, " {\n");

        ++amount_space;
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
