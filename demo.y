%{
#include<stdio.h>
#include<stdlib.h>

int yylex();
void yyerror(char *s);
%}

%union{
    char *str;
}

%token <str> ID

%%

start:
      start line
    |
    ;

line:
      ID '=' ID '+' ID '\n'
      { printf("LDA %s\nADD %s\nSTA %s\n\n",$3,$5,$1); }

    | ID '=' ID '-' ID '\n'
      { printf("LDA %s\nSUB %s\nSTA %s\n\n",$3,$5,$1); }

    | ID '=' ID '*' ID '\n'
      { printf("LDA %s\nMUL %s\nSTA %s\n\n",$3,$5,$1); }

    | ID '=' ID '/' ID '\n'
      { printf("LDA %s\nDIV %s\nSTA %s\n\n",$3,$5,$1); }
    ;

%%

int main()
{
    printf("Enter Expressions:\n");
    yyparse();
    return 0;
}

void yyerror(char *s)
{
    printf("Invalid Expression\n");
}