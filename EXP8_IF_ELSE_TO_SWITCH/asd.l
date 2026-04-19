%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%

if              return IF;
else            return ELSE;
==              return EQ;

\(              return LPAREN;
\)              return RPAREN;
\{              return LBRACE;
\}              return RBRACE;
;               return SEMI;

[0-9]+          { yylval.num = atoi(yytext); return NUM; }

[a-zA-Z_][a-zA-Z0-9_]*   { strcpy(yylval.id, yytext); return ID; }

[ \t\n]+        ;

.               return yytext[0];

%%

int yywrap()
{
    return 1;
}