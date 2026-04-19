%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int yylex();
void yyerror(char *s);

FILE *yyin;
FILE *fp;
%}

%union
{
    char *str;
}

%token <str> NUM ID
%token PLUS MINUS MUL DIV LP RP NL

%type <str> E T F

%%

S : E NL
    {
        fprintf(fp,"%s\n",$1);
    }
  ;

E : E PLUS T
    {
        $$ = malloc(100);
        sprintf($$,"%s %s +",$1,$3);
    }
  | E MINUS T
    {
        $$ = malloc(100);
        sprintf($$,"%s %s -",$1,$3);
    }
  | T { $$ = $1; }
  ;

T : T MUL F
    {
        $$ = malloc(100);
        sprintf($$,"%s %s *",$1,$3);
    }
  | T DIV F
    {
        $$ = malloc(100);
        sprintf($$,"%s %s /",$1,$3);
    }
  | F { $$ = $1; }
  ;

F : LP E RP { $$ = $2; }
  | ID      { $$ = $1; }
  | NUM     { $$ = $1; }
  ;

%%

int main()
{
    yyin = fopen("input.txt","r");
    fp = fopen("postfix_output.txt","w");

    yyparse();

    fclose(yyin);
    fclose(fp);

    printf("Postfix Code written to postfix_output.txt\n");
    return 0;
}

void yyerror(char *s)
{
    printf("Invalid Expression\n");
}