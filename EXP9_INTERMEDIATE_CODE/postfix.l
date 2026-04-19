%{
#include "y.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+          { yylval.str = strdup(yytext); return NUM; }
[a-zA-Z]+       { yylval.str = strdup(yytext); return ID; }

"+"             return PLUS;
"-"             return MINUS;
"*"             return MUL;
"/"             return DIV;
"("             return LP;
")"             return RP;
"\n"            return NL;

[ \t]           ;
.               return yytext[0];

%%

int yywrap()
{
    return 1;
}