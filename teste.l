%{
	#include "sintatico.h"
%}

/* Expressões Regulares */


INT         [-+]?[0-9]+
exponant	[eE]{INT}
FLOAT       {INT}("."{INT})?{exponant}?
CHAR        (\')[.]?(\')
STRING      ("\""){.}+("\"")
WHITESPACE  [ \t\v\f]*

/* Regras */
%%

{WHITESPACE}	{ }
{INT}			{ yylval = atof(yytext); return(TK_RE_INT); }
{FLOAT}			{ yylval = atof(yytext); return(TK_RE_FLOAT); }
CHAR			{ yylval = atof(yytext); return(TK_RE_CHAR); }
STRING			{ yylval = atof(yytext); return(TK_RE_STRING); }
";"				{ return(END); }

%%

void yyerror(char* str) {
	printf("Erro: \n%s\n", str);
}

int main() {
	void yyparser();
	return 0;
}




