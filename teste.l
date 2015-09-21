%{
	#include "sintatico.h"
%}

/* Expressões Regulares */

digit		[0-9]
INT         {digit}+
exponant	[eE][+-]?{INT}
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

yywrap () {
	return 0;
}


