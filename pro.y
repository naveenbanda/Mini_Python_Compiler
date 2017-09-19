%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	#define border printf("\n...........................................\n")
	int yydebug=1;
%}

%token	ID NUMBER STRING_LIT STRING_VAR
%token	EQ PLUS MINUS MUL DIVIDE LBRACKET RBRACKET SEMICOLON
%token	PRINT RARE
%right	EQ
%left	PLUS MINUS
%left	MUL DIVIDE

%%

start			:	stmt|SEMICOLON{printf("\nThis is a valid python expression\n");border;YYACCEPT;}
stmt			:	assign_arithmetic|assign_str|display
identifier		:	ID|keyword{yyerror("\nKeyword can't be used as an identifier\n");YYABORT;}
keyword			:	PRINT|RARE	
assign_str		:	identifier EQ strings
display			:	PRINT strings|PRINT strings MUL NUMBER|PRINT strings PLUS strings|PRINT expr
strings			:	STRING_LIT|STRING_VAR
assign_arithmetic	:	identifier EQ expr
expr			:	expr PLUS expr|expr MINUS expr|expr MUL expr|expr DIVIDE expr|factor|LBRACKET expr RBRACKET|SIGN factor
SIGN			:	PLUS|MINUS
factor			:	identifier|NUMBER

%%

main()
{
	printf("\n..........PTYHON EXPRESSION PARSER...................\n");
	printf("\nEnter a python expression :\n");
	return yyparse();
}

yyerror(s)
char *s;
{
	printf("\n%s\n",s);
	border;
}

yywrap()
{
	return (1);
}


