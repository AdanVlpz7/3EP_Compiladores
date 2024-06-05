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
{NUM} {yylval = atoi(yytext); return NUMBER;}
[-+*();]    {return *yytext;}
"big"       {return B;}
"large"      {  return G;}
"number"      {  return NU;}
"real"      {  return X;}
"symbol"      {  return Y;}

\$[a-zA-Z]+ { return ID; }

(([1-9][0-9]*\.[0-9]+)|(\.[0-9]+)) { return R; }

\"([^"]|\\.)*\"|'([^']|\\.)*' { return S; }

[[:blank:]] ;
. yyerror("Unknown character");

%%