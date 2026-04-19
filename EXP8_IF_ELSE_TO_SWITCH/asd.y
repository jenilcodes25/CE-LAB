%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int yylex();
void yyerror(const char *s);

char varname[50];

int cases[100];
int count = 0;
%}

%union
{
    int num;
    char id[50];
}

%token IF ELSE EQ
%token LPAREN RPAREN LBRACE RBRACE SEMI
%token <num> NUM
%token <id> ID

%%

start :
      first_if rest_part
      {
          int i;

          printf("\nEquivalent switch-case statement:\n");
          printf("switch(%s)\n{\n", varname);

          for(i=0;i<count;i++)
          {
              printf("   case %d:\n", cases[i]);
              printf("      statement;\n");
              printf("      break;\n\n");
          }

          printf("   default:\n");
          printf("      statement;\n");
          printf("}\n");
      }
      ;

first_if :
      IF LPAREN ID EQ NUM RPAREN action
      {
          strcpy(varname,$3);
          cases[count++] = $5;
      }
      ;

rest_part :
      ELSE IF LPAREN ID EQ NUM RPAREN action rest_part
      {
          cases[count++] = $6;
      }
    |
      ELSE action
      {
      }
      ;

action :
      LBRACE ID SEMI RBRACE
      ;

%%

int main()
{
    printf("Enter if-else ladder:\n");
    yyparse();
    return 0;
}

void yyerror(const char *s)
{
    printf("Syntax Error\n");
}