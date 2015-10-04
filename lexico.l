%option noyywrap
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
	printf("\nLexico: Encontrado: Biblioteca: %s", yytext);
	yylval.string = (char*) malloc(sizeof(char)*strlen(yytext));
	strcpy(yylval.string, yytext);
	return(TK_LIBRARY);
}

{TYPE} {
	printf("\n\nLexico: Encontrado TYPE: %s", yytext);

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
	printf("\nLexico: Encontrado INT de valor: %d\n", atoi(yytext));
	yylval.number_int = atoi(yytext);
	return(TK_VALUE_INT);
}

{FLOAT} {
	printf("\nLexico: Encontrado FLOAT de valor: %f\n", atof(yytext));
	yylval.number_float = atof(yytext);
	return(TK_VALUE_FLOAT);
}

{CHAR} {
	printf("\nLexico: Encontrado CHAR atribuido => %c", yytext[1]);
	yylval.caracter = yytext[1];
	return(TK_VALUE_CHAR);
}

";"	{
	printf("Lexico: Encontrado: ;\n");
	return(TK_END_INST_LINE);
}

"{" {
	printf("\nLexico: Encontrado: {\n");
	return(TK_INIT_INST);
}

"}" {
	printf("\nLexico: Encontrado: }\n");
	return(TK_END_INST);
}

"(" {
	printf("\nLexico: Encontrado: (\n");
	return(TK_INIT_BRACKETS);
}

")" {
	printf("\nLexico: Encontrado: )\n");
	return(TK_END_BRACKETS);
}

"," {
	printf("\nLexico: Encontrado: ,\n");
	return(TK_COMA);
}

"return" {
	printf("\nLexico: Encontrado: return");
	return(TK_RE_RETURN);
}

{VARIABLE} {
	printf("\nLexico: Encontrado VARIAVEL: %s\n", yytext);
	yylval.string = (char*) malloc(sizeof(char)*strlen(yytext));
	strcpy(yylval.string, yytext);
	return(TK_VARIABLE);
}

"=" {
	printf("Lexico: Encontrado: %c", yytext[0]);
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

	exit(0);
}
