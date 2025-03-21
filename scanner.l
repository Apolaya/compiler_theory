/* CMSC 430 Compiler Theory and Design
   Project 1 Skeleton
   UMGC CITE
   Summer 2023 */
   
   //jonathan apolaya
   //UMGC CMSC 430 


/* This file contains flex input file */



%{
#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws		[ \t\r]+
comment		"//".*\n
line		[\n]
id		[A-Za-z]([_]{0,2}[A-Za-z0-9])*	

digit		[0-9]
dec		{digit}+
char		'([^\\]|\\[btnrf'\\])'
hex		"#"[0-9A-Fa-f]+
punc		[\(\),:;_]
%%


{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine(); }
{line}		{ ECHO; nextLine(); }
"=>"		{ ECHO; return(ARROW); }
"+" 		{ ECHO; return(ADDOP); }
"-"		{ ECHO; return(ADDOP); }
"/"		{ ECHO; return (ADDOP);}
"*"		{ ECHO; return(MULOP); }
"&"		{ ECHO; return(ANDOP); }
"%"		{ ECHO; return (REMOP);}
"^"		{ ECHO; return (EXPOP);}
"~"		{ ECHO; return (NEGOP);}

"<"     { ECHO; return(RELOP); }
">"     { ECHO; return(RELOP); }
"="     { ECHO; return(RELOP); }
"<>"    { ECHO; return(RELOP); }
">="    { ECHO; return(RELOP); }
"<="    { ECHO; return(RELOP); }

"|"		{ ECHO; return(OROP);  }
"!"		{ ECHO; return(NOTOP); }
begin		{ ECHO; return(BEGIN_); }
case		{ ECHO; return(CASE); }
character	{ ECHO; return(CHARACTER); }
end		{ ECHO; return(END); }
endswitch	{ ECHO; return(ENDSWITCH); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
list		{ ECHO; return(LIST); }
of		{ ECHO; return(OF); }
others		{ ECHO; return(OTHERS); }
returns		{ ECHO; return(RETURNS); }
switch		{ ECHO; return(SWITCH); }
when		{ ECHO; return(WHEN); }
else		{ ECHO; return(ELSE); }
elif		{ ECHO; return(ELIF); }
endfold		{ ECHO; return(ENDFOLD); }
fold		{ ECHO; return(FOLD); }
if		{ ECHO; return(IF); }
left		{ ECHO; return(LEFT); }

((\.[0-9]+)|([0-9]+\.[0-9]*))([eE][+-]?[0-9]+)? { ECHO; return(REAL);}
right		{ ECHO; return(RIGHT); }
then		{ ECHO; return(THEN); }

{hex}		{ ECHO; return(HEX_LITERAL);}
{id}		{ ECHO; return(IDENTIFIER);}
{dec}		{ ECHO; return(INT_LITERAL); }
{char}		{ ECHO; return(CHAR_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.		{ ECHO; appendError(LEXICAL, yytext); }
%%

int main() {
	firstLine();
	
	FILE *file = fopen("lexemes.txt", "wa"); 
	int token = yylex();
	while (token) {
		fprintf(file, "%d %s\n", token, yytext);
		token = yylex();
	}
	lastLine();
	fclose(file);
	return 0;
}
