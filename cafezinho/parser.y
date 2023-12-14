%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lex.yy.c"
%}

%token ID INTCONST CONSTSTRING
%token PROGRAMA CAR INT RETORNE LEIA ESCREVA NOVALINHA SE ENTAO SENAO ENQUANTO EXECUTE OU
%left '+' '-'
%left '*' '/' '%'
%left '!' UNARY_MINUS
%nonassoc '<' '>' ">=" "<="
%left "==" "!="
%left "e" OU
%nonassoc '?'

%%

Programa: DeclFuncVar DeclProg;

DeclFuncVar: Tipo ID DeclVar ';' DeclFuncVar
           | Tipo ID '[' INTCONST ']' DeclVar ';' DeclFuncVar
           | Tipo ID DeclFunc DeclFuncVar
           |;

DeclProg: PROGRAMA Bloco;

DeclVar: ',' ID DeclVar
        | ',' ID '[' INTCONST ']' DeclVar
        |;

DeclFunc: '(' ListaParametros ')' Bloco;

ListaParametros: Tipo ID
               | Tipo ID '[' ']' 
               | Tipo ID ',' ListaParametros;

Bloco: '{' ListaDeclVar ListaComando '}'
     | '{' ListaComando '}';

ListaDeclVar: Tipo ID DeclVar ';' ListaDeclVar
            | Tipo ID '[' INTCONST ']' DeclVar ';' ListaDeclVar
            |;

Tipo: INT | CAR;

ListaComando: Comando
            | Comando ListaComando;

Comando: ';' 
        | Expr ';' 
        | RETORNE Expr ';' 
        | LEIA LValueExpr ';' 
        | ESCREVA Expr ';' 
        | ESCREVA CONSTSTRING ';' 
        | NOVALINHA ';' 
        | SE '(' Expr ')' ENTAO Comando 
        | SE '(' Expr ')' ENTAO Comando SENAO Comando 
        | ENQUANTO '(' Expr ')' EXECUTE Comando 
        | Bloco;

Expr: AssignExpr;

AssignExpr: CondExpr
          | LValueExpr '=' AssignExpr;

CondExpr: OrExpr 
        | OrExpr '?' Expr ':' CondExpr;

OrExpr: OrExpr OU AndExpr
      | AndExpr;

AndExpr: AndExpr 'e' EqExpr
       | EqExpr;

EqExpr: EqExpr "==" DesigExpr
      | EqExpr "!=" DesigExpr
      | DesigExpr;

DesigExpr: DesigExpr '<' AddExpr
         | DesigExpr '>' AddExpr
         | DesigExpr ">=" AddExpr
         | DesigExpr "<=" AddExpr
         | AddExpr;

AddExpr: AddExpr '+' MulExpr
       | AddExpr '-' MulExpr
       | MulExpr;

MulExpr: MulExpr '*' UnExpr
       | MulExpr '/' UnExpr
       | MulExpr '%' UnExpr
       | UnExpr;

UnExpr: '-' PrimExpr %prec UNARY_MINUS
      | '!' PrimExpr
      | PrimExpr;

LValueExpr: ID '[' Expr ']' 
          | ID;

PrimExpr: ID '(' ListExpr ')' 
        | ID '(' ')' 
        | ID '[' Expr ']' 
        | ID 
        | CONSTSTRING 
        | INTCONST 
        | '(' Expr ')';

ListExpr: AssignExpr 
         | ListExpr ',' AssignExpr;

%%


int yyerror(char *s) {
    fprintf(stderr, "ERRO: %s\n", s);
    return 0;
}

int main() {
    yyparse();
    return 0;
}

