%{
#include <stdio.h>
int yylex(void);
void yyerror(char *s);

%}
%token B ID G Y X R S NU
%token NUMBER
%left '=' ','
%start inicio
%%
inicio :
    declaraciones
    ;

declaraciones:
    declaraciones '\n' declaracion
    | declaraciones declaracion
    | declaracion
    ;

tipo :
    B {printf("Las variables son de tipo big\n");}
    | G {printf("Las variables son de tipo large\n");}
    | NU {printf("Las variables son de tipo number\n");}
    | Y {printf("Las variables son de tipo symbol\n");}
    | X {printf("Las variables son de tipo real\n");}
    ;

declaracion :
    tipo lista_ids ';'
    ;

lista_ids :
    ID contenido
    | lista_ids ',' ID contenido
    ;

contenido : 
    /* vacío */
    | '=' valor continuacion
    ;

valor: 
    NUMBER
    | R 
    | S
    ;

continuacion: 
    /* vacío */
    | ',' ID contenido
    ;
%%

void yyerror(char *s)
{
    printf("\n%s\n", s);
}

extern FILE *yyin;

int main(int argc, char **argv){
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror(argv[1]);
            return 1;
        }
    }
    yyparse();
    return 0;
}
