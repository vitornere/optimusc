%{
#include <stdio.h>
#include "sintatico.h"
%}

%token TK_RE_INT
%token TK_RE_FLOAT
%token TK_RE_BOOL
%token TK_RE_CHAR
%token TK_RE_STRING
%token END
%start start

%%

start:

%%

int yywrap(void) { return 1; }