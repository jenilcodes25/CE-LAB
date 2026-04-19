%{
#include "y.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%

"="     return ASSIGN;
"+"     return PLUS;
"-"     return MINUS;
"*"     return MUL;
"/"     return DIV;
\n      return NL;

[a-zA-Z][a-zA-Z0-9]*   { yylval.str=strdup(yytext); return ID; }

[ \t]   ;

.       ;

%%

int yywrap()
{
    return 1;
}