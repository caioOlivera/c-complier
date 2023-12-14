%{
#include "parser.tab.h"
%}

%option noyywrap

%%

programa     { return PROGRAMA; }
car          { return CAR; }
int          { return INT; }
retorne      { return RETORNE; }
leia         { return LEIA; }
escreva      { return ESCREVA; }
novalinha    { return NOVALINHA; }
se           { return SE; }
entao        { return ENTAO; }
senao        { return SENAO; }
enquanto     { return ENQUANTO; }
execute      { return EXECUTE; }
ou           { return OU; }

[a-zA-Z_][a-zA-Z_0-9]*   { yylval.str = strdup(yytext); return ID; }
[0-9]+                  { yylval.ival = atoi(yytext); return INTCONST; }
\"([^\\\n]|(\\.))*?\"   { yylval.str = strdup(yytext); return CONSTSTRING; }

"/*"([^*]|"*"+[^*/])*"*"+"/"  { /* Ignora comentários */ }
[ \t\n]             ;  /* Ignora espaços em branco e tabulações */

.                   { yyerror("CARACTERE INVALIDO"); }

%%

int yywrap(void) {
    return 1;
}

