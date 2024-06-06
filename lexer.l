/*autores:
Resendiz Casas Axel A.
Vargas Lopez Miguel Adan
Vargas Zaldivar Aidee Jacqueline
*/

%{
    #include <stdio.h>
    #include "parser1.tab.h"
    void yyerror(char *);
%}

%option noyywrap

DIGIT [0-9]
NUM {DIGIT}+("."{DIGIT}+)?

/* Rule Section */
%%
{NUM}                { yylval = atoi(yytext); return NUMBER; }
[-+*();=,]             { return *yytext; }

"big"                { return B; }
"large"              { return G; }
"number"             { return NU; }
"real"               { return X; }
"symbol"             { return Y; }

\$[a-zA-Z_][a-zA-Z0-9_]* { return ID; }
(([1-9][0-9]*\.[0-9]+)|(\.[0-9]+)) { return R; }
\"([^"]|\\.)*\"      { return S; }
\'([^']|\\.)*\'      { return S; }
[[:blank:]]          { /* Ignorar espacios en blanco */ }

\n                   { return '\n'; } /* Reconocer saltos de línea */

.                    { yyerror("Caracter no reconocido"); }

%%
