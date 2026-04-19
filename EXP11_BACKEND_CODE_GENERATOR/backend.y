%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int yylex();
void yyerror(char *s);

extern FILE *yyin;
FILE *fp;
%}

%union
{
    char *str;
}

%token <str> ID
%token ASSIGN PLUS MINUS MUL DIV NL

%%

start :
      program
      ;

program :
      program stmt NL
    |
      stmt NL
    ;

stmt :
      ID ASSIGN ID PLUS ID
      {
          fprintf(fp,"LDA %s\n",$3);
          fprintf(fp,"LDT %s\n",$5);
          fprintf(fp,"ADDR A,T\n");
          fprintf(fp,"STA %s\n\n",$1);
      }

    | ID ASSIGN ID MINUS ID
      {
          fprintf(fp,"LDA %s\n",$3);
          fprintf(fp,"LDT %s\n",$5);
          fprintf(fp,"SUBR A,T\n");
          fprintf(fp,"STA %s\n\n",$1);
      }

    | ID ASSIGN ID MUL ID
      {
          fprintf(fp,"LDA %s\n",$3);
          fprintf(fp,"LDT %s\n",$5);
          fprintf(fp,"MULR A,T\n");
          fprintf(fp,"STA %s\n\n",$1);
      }

    | ID ASSIGN ID DIV ID
      {
          fprintf(fp,"LDA %s\n",$3);
          fprintf(fp,"LDT %s\n",$5);
          fprintf(fp,"DIVR A,T\n");
          fprintf(fp,"STA %s\n\n",$1);
      }
      ;

%%

int main()
{
    yyin = fopen("tac_input.txt","r");
    fp   = fopen("machine_output.txt","w");

    if(yyin == NULL)
    {
        printf("Input file not found\n");
        return 0;
    }

    yyparse();

    fclose(yyin);
    fclose(fp);

    printf("Machine code written to machine_output.txt\n");
    return 0;
}

void yyerror(char *s)
{
    printf("Syntax Error\n");
}