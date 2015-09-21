%{
#include <stdio.h>
#include "sintatico.h"
%}

%token TK_RE_INT
%token TK_RE_FLOAT
%token TK_RE_CHAR
%token TK_RE_STRING
%token END
%start start

%%
3 3.3 's' "ss"

int x = 3;

start: end

end: END | string

string: TK_RE_STRING | char

char: TK_RE_CHAR | float

float: TK_RE_FLOAT | int

int: TK_RE_INT

%%

int yywrap(void) { return 1; }