%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

//Define the tokens that you want to return from your lex as follows
#define ID 256
#define INTVAL 257
#define FLTVAL 258
#define DBLVAL 259

int list_type;
%}

%option noyywrap nounput yylineno
ID [a-zA-Z][a-zA-Z0-9_]*
INTVAL [0-9]+
FLTVAL [0-9]*[.][0-9]+[f]
DBLVAL [0-9]*[.][0-9]+
%x COMMENT BLOCKCOMMENT PREPROC STRVAL CHARVAL

%%
"\n" {}

"(" {
  printf("(\n");
}

")" {
  printf(")\n");
}

"[" {
  printf("[\n");
}

"]" {
  printf("]\n");
}

"," {
  printf(",\n");
}

";" {
  printf(";\n");
}

" " {}

"void" {
  printf("VOID\n");
}

"short" {
  printf("SHORT\n");
}

"long" {
  printf("LONG\n");
}

"double" {
  printf("DOUBLE\n");
}

"char" {
  printf("CHAR\n");
}

"int" {
  printf("INT\n");
}

"float" {
  printf("FLOAT\n");
}

"==" {
  printf("EQ\n");
}

"<=" {
  printf("LE\n");
}

"+" {
  printf("ADD\n");
}

"/" {
  printf("DIV\n");
}

"&&" {
  printf("AND\n");
}

"^" {
  printf("BITXOR\n");
}

"<<" {
  printf("LSH\n");
}

"+=" {
  printf("SETADD\n");
}

"/=" {
  printf("SETDIV\n");
}

"&=" {
  printf("SETAND\n");
}

"SETRSH" {
  printf(">>=\n");
}

"!=" {
  printf("NE\n");
}

">" {
  printf("GT\n");
}

"-" {
  printf("SUB\n");
}

"%" {
  printf("MOD\n");
}

"|" {
  printf("BITOR\n");
}

"!" {
  printf("NOT\n");
}

">>" {
  printf("RSH\n");
}

"-=" {
  printf("SETSUB\n");
}

"%=" {
  printf("SETMOD\n");
}

"^=" {
  printf("SETXOR\n");
}

">=" {
  printf("GE\n");
}

"<" {
  printf("LT\n");
}

"*" {
  printf("MUL\n");
}

"||" {
  printf("OR\n");
}

"&" {
  printf("BITAND\n");
}

"~" {
  printf("COM\n");
}

"=" {
  printf("SET\n");
}

"*=" {
  printf("SETMUL\n");
}

"|=" {
  printf("SETOR\n");
}

"SETLSH" {
  printf("<<=\n");
}

"return" {
  printf("RETURN\n");
}

"while" {
  printf("WHILE\n");
}

"switch" {
  printf("SWITCH\n");
}

"default" {
  printf("DEFAULT\n");
}

"else" {
  printf("ELSE\n");
}

"break" {
  printf("BREAK\n");
}

"do" {
  printf("DO\n");
}

"for" {
  printf("FOR\n");
}

"case" {
  printf("CASE\n");
}

"if" {
  printf("IF\n");
}

"continue" {
  printf("CONTINUE\n");
}

"goto" {
  printf("GOTO\n");
}

"unsigned" {
  printf("UNSIGNED\n");
}

"struct" {
  printf("STRUCT\n");
}

"const" {
  printf("CONST\n");
}

"extern" {
  printf("EXTERN\n");
}

"register" {
  printf("REGISTER\n");
}

"typedef" {
  printf("TYPEDEF\n");
}

"union" {
  printf("UNION\n");
}

"static" {
  printf("STATIC\n");
}

"auto" {
  printf("AUTO\n");
}

"sizeof" {
  printf("SIZEOF\n");
}

"#" {
  printf("PREPROC\n");
  BEGIN PREPROC;
}

<PREPROC>[\n](\r)? {
  BEGIN 0;
}

<PREPROC>[ \t] {}

<PREPROC>. {}

"//" {
  BEGIN COMMENT;
}

<COMMENT>[\n](\r)? {
  BEGIN 0;
}

<COMMENT>[ \t] {}

<COMMENT>. {}

"/*" {
  BEGIN BLOCKCOMMENT;
}

<BLOCKCOMMENT>[\n](\r)? {}

<BLOCKCOMMENT>[ \t] {}

<BLOCKCOMMENT>"*/" {
  BEGIN 0;
}

<BLOCKCOMMENT>. {}

["] {
  printf("STRVAL\n");
  BEGIN STRVAL;
}

<STRVAL>[\n](\r)? {}

<STRVAL>[ \t] {}

<STRVAL>["] {
  BEGIN 0;
}

<STRVAL>. {}

['] {
  printf("CHARVAL\n");
  BEGIN CHARVAL;
}

<CHARVAL>[\n](\r)? {}

<CHARVAL>[ \t] {}

<CHARVAL>['] {
  BEGIN 0;
}

<CHARVAL>. {}

"{" {
  printf("{\n");
}

"}" {
  printf("}\n");
}

"\t" {}

{ID} {
  printf("ID\n");
  return ID;
}

{INTVAL} {
  printf("INTVAL\n");
  return INTVAL;
}

{FLTVAL} {
  printf("FLTVAL\n");
  return FLTVAL;
}

{DBLVAL} {
  printf("DBLVAL\n");
  return DBLVAL;
}

. {}

%%
int main(int argc, const char* argv[])
{
  while(yylex() != 0) {}
  return 0;
}
