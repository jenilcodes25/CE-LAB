%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int yylex();
void yyerror(char *s);

extern FILE *yyin;
FILE *fp;

int temp = 1;

char* newtemp()
{
    char *p = malloc(10);
    sprintf(p,"t%d",temp++);
    return p;
}
%}

%union
{
    char *str;
}

%token <str> NUM ID
%token PLUS MINUS MUL DIV LP RP NL

%type <str> E T F

%%

S : E
    {
        fprintf(fp,"\nResult = %s\n",$1);
        return 0;
    }
  ;

E : E PLUS T
    {
        char *t = newtemp();
        fprintf(fp,"%s = %s + %s\n",t,$1,$3);
        $$ = t;
    }
  | E MINUS T
    {
        char *t = newtemp();
        fprintf(fp,"%s = %s - %s\n",t,$1,$3);
        $$ = t;
    }
  | T { $$ = $1; }
  ;

T : T MUL F
    {
        char *t = newtemp();
        fprintf(fp,"%s = %s * %s\n",t,$1,$3);
        $$ = t;
    }
  | T DIV F
    {
        char *t = newtemp();
        fprintf(fp,"%s = %s / %s\n",t,$1,$3);
        $$ = t;
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
    fp = fopen("tac_output.txt","w");

    yyparse();

    fclose(yyin);
    fclose(fp);

    printf("Three Address Code written to tac_output.txt\n");
    return 0;
}

void yyerror(char *s)
{
    printf("Invalid Expression\n");
}