%option noyywrap
%option yylineno

%{
	#include "sintatico.h"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "lista.h"
	extern FILE *yyin;
%}

/************************/
/* Expressões Regulares */
/************************/

INT         [-+]?[0-9]+
exponant	[eE]{INT}
FLOAT       {INT}("."[0-9]+)?{exponant}?
STRING		("\"")(([a-zA-Z0-9_]*)[ \t\v\f]*)*("\"")
CHAR        (\').{1}(\')
WHITESPACE  [ \t\v\f]*
NEWLINE		[\n|\n\l|\r\n]
VARIABLE	([a-zA-Z_][a-zA-Z0-9_]*)
TYPE		(int|float|char)
LIBRARY 	("#include"{WHITESPACE}("\""|<){VARIABLE}".h"("\""|>))

/* Regras */
%%

{WHITESPACE} {
	// Ignore Spaces
}

{NEWLINE} {
	// Ignore Lines
}

{LIBRARY} {
	yylval.string = (char*) malloc(sizeof(char)*strlen(yytext));
	strcpy(yylval.string, yytext);
	return(TK_LIBRARY);
}

{TYPE} {

	if(!strcmp(yytext, "int")) {
		return(TK_RE_INT);
	}
	else if(!strcmp(yytext, "float")) {
		return(TK_RE_FLOAT);
	}
	else if(!strcmp(yytext, "char")) {
		return(TK_RE_CHAR);
	}
}

{INT} {
	yylval.number_int = atoi(yytext);
	return(TK_VALUE_INT);
}

{FLOAT} {
	yylval.number_float = atof(yytext);
	return(TK_VALUE_FLOAT);
}

{CHAR} {
	yylval.caracter = yytext[1];
	return(TK_VALUE_CHAR);
}

{STRING} {
	yylval.string = (char*) malloc(sizeof(char)*strlen(yytext));
	strcpy(yylval.string, yytext);
	return(TK_VALUE_STRING);
}

"+" {
	return(TK_PLUS);
}

"-" {
	return(TK_MINUS);
}

"*" {
	return(TK_TIMES);
}

"/" {
	return(TK_DIVI);
}

";"	{
	return(TK_END_INST_LINE);
}

"{" {
	return(TK_INIT_INST);
}

"}" {
	return(TK_END_INST);
}

"(" {
	return(TK_INIT_BRACKETS);
}

")" {
	return(TK_END_BRACKETS);
}

"," {
	return(TK_COMA);
}

"return" {
	return(TK_RE_RETURN);
}

"else" {
	return(TK_RE_ELSE);
}


"if" {
	return(TK_RE_IF);
}

{VARIABLE} {
	yylval.string = (char*) malloc(sizeof(char)*strlen(yytext));
	strcpy(yylval.string, yytext);
	return(TK_VARIABLE);
}

"=" {
	return(TK_ATTRIBUITION);
}

"<" {
	return(TK_COMPARISON_LT);
}
">" {
	return(TK_COMPARISON_GT);
}

"==" {
	return(TK_COMPARISON_ET);
}

"!=" {
	return(TK_COMPARISON_DT);
}

"&&" {
	return(TK_AND);
}

"||" {
	return(TK_OR);
}

<<EOF>> {
	return(END);
}

%%

void yyerror(char* str) {
}

int main() {


	if((yyin = fopen("entrada.c", "r")) == NULL) {
		exit(1);
	}

	if(!yyparse()){
        printf("\nAnalise sintatica OK!\n");
    } else {
        printf("\nERRO na analise sintatica!\n");
    }

    yylex();

	void yyparser();

	exit(0);
}
