%option noyywrap
%option nomain
%option yylineno

%{
	#include "sintatico.h"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	extern FILE* yyin;
%}

/* Expressões Regulares */


INT         [-+]?[0-9]+
exponant	[eE]{INT}
FLOAT       {INT}("."[0-9]+)?{exponant}?
CHAR        (\')[.]?(\')
STRING      ("\""){.}+("\"")
WHITESPACE  [ \t\v\f]*
NEWLINE		[\n|\n\l|\r\n]
VARIABLE	([a-zA-Z_][a-zA-Z0-9_]*)
TYPE		(int|float|char)
ATTRIBUITION ("=")

/* Regras */
%%

{WHITESPACE} {
	// Ignore Spaces
}

{NEWLINE} {
	// Ignore Lines
}

{TYPE} {
	printf("\nLexico: Encontrado TYPE => %s", strdup(yytext));
	yylval.type = (char*) malloc(sizeof(char)*strlen(strdup(yytext)));
	strcpy(yylval.type, strdup(yytext));
	return(TK_TYPE);
}

{INT} {
	printf("\nLexico: Encontrado INT atribuido => %d", atof(yytext));
	yylval.number_int = atof(yytext);
	return(TK_VALUE_INT);
}

{FLOAT} {
	printf("\nLexico: Encontrado FLOAT atribuido => %f", atof(yytext));
	yylval.number_float = atof(yytext);
	return(TK_VALUE_FLOAT);
}

{CHAR} {
	printf("\nLexico: Encontrado CHAR atribuido => %c", atof(yytext));
	yylval.caracter = atof(yytext);
	return(TK_VALUE_CHAR);
}

STRING {
	printf("\nLexico: Encontrado STRING atribuido => %s", atof(yytext));
	yylval.string = strdup(yytext);
	return(TK_VALUE_STRING);
}

";"	{
	printf("\nLexico: Encontrado ;");
	return(TK_END_INST_LINE);
}

"{" {
	printf("\nLexico: Encontrado {");
	return(TK_INIT_INST);
}

"}" {
	printf("\nLexico: Encontrado }");
	return(TK_END_INST);
}

{VARIABLE} {
	printf("\nLexico: Encontrado VARIAVEL %s\n", yytext);
	yylval.variable = (char*) malloc(sizeof(char)*strlen(strdup(yytext)));
	strcpy(yylval.variable, strdup(yytext));
	return(TK_VARIABLE);
}

ATTRIBUITION {
	printf("\nLexico: Encontrado %c", yytext);
	yylval.caracter = atof(yytext);
	return(TK_ATTRIBUITION);
}

%%

void yyerror(char* str) {
	printf("\nErro: %s\n", str);
}

int main() {
	if((yyin = fopen("entrada.txt", "r")) == NULL) {
		printf("\nErro ao abrir o arquivo!\n");
		exit(1);
	}

	if(!yyparse()){
        printf("\nAnalise sintatica OK!\n");
    } else {
        printf("\nERRO na analise sintatica!\n");
    }

    yylex();

	void yyparser();

	return 0;
}