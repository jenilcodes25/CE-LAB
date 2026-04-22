%{
#include "y.tab.h"
#include <string.h>
%}

%%

[a-zA-Z]+   { yylval.str=strdup(yytext); return ID; }
"="         return '=';
"+"         return '+';
"-"         return '-';
"*"         return '*';
"/"         return '/';
\n          return '\n';
[ \t]       ;
.           ;

%%

int yywrap()
{
    return 1;
}