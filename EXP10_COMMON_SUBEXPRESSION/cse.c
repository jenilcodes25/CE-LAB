#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct TAC
{
    char lhs[20];
    char op1[20];
    char op[5];
    char op2[20];
};

struct TAC code[100];
int n = 0;

int main()
{
    FILE *fp;
    char line[100];

    fp = fopen("tac_output.txt", "r");

    if(fp == NULL)
    {
        printf("File not found\n");
        return 0;
    }

    /* Read TAC lines */
    while(fgets(line, sizeof(line), fp))
    {
        if(sscanf(line,"%s = %s %s %s",
            code[n].lhs,
            code[n].op1,
            code[n].op,
            code[n].op2) == 4)
        {
            n++;
        }
    }

    fclose(fp);

    printf("\nOriginal Three Address Code:\n\n");

    for(int i=0;i<n;i++)
    {
        printf("%s = %s %s %s\n",
            code[i].lhs,
            code[i].op1,
            code[i].op,
            code[i].op2);
    }

    printf("\nAfter Common Subexpression Elimination:\n\n");

    int remove[100]={0};

    for(int i=0;i<n;i++)
    {
        for(int j=i+1;j<n;j++)
        {
            if(strcmp(code[i].op1,code[j].op1)==0 &&
               strcmp(code[i].op,code[j].op)==0 &&
               strcmp(code[i].op2,code[j].op2)==0)
            {
                printf("%s replaced by %s\n",
                        code[j].lhs,
                        code[i].lhs);

                remove[j]=1;
            }
        }
    }

    printf("\nOptimized Code:\n\n");

    for(int i=0;i<n;i++)
    {
        if(remove[i]==0)
        {
            printf("%s = %s %s %s\n",
                code[i].lhs,
                code[i].op1,
                code[i].op,
                code[i].op2);
        }
    }

    return 0;
}