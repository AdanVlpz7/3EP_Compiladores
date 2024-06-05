%{
#include <stdio.h>
int yylex(void);
void yyerror(char *s);

%}
%token B, ID, G, Y, X, R, S, NU
%token NUMBER
%left '+' '-'
%left '*'

%%
list :
    | list '\n'
    | list exp {printf("%d\n",$2);}
    ;

exp : exp '+' term {$$ = $1 + $3;}
    | exp '-' term {$$ = $1 - $3;}
    | term {$$ = $1;}
    ;

term : term '*' factor {$$ = $1 * $3;}
    | factor {$$ = $1;}
    ;

factor : NUMBER {$$ = $1;}
    | '(' exp ')' {$$ = $2;}
    ;

%%

void yyerror(char *s)
{
    printf("\n%s\n",s);
}

extern FILE * yyin;
int main(int argc, char **argv){
    if(argc > 1) yyin = fopen(argv[1],"r");
    yyparse();
    return 0;
}