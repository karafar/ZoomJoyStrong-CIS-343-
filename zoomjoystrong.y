%{
/*
	Farid Karadsheh
	Prof. Woodring
	GVSU CIS343
	11/30/2018

	Contains the grammar rules for our parser, and contains a few functions
	for checking user input.
*/

#include <stdio.h>
#include "zoomjoystrong.h"
int yylex();
int yyerror(const char* msg);
const char* errmsg = "Error: Invalid range!\n";

int isValidCoordinate(int, int);
int isValidRect(int, int, int, int);
int isValidCircle(int, int, int);
int ivc(int);
int isValidColor(int, int, int);
%}

%union {
	int iVal;
}

%token END;
%token EOS;
%token POINT;
%token LINE;
%token RECTANGLE;
%token CIRCLE;
%token SET_COLOR;
%token INT;


%type<iVal> INT;

%%
statement_list: statement
	|	statement statement_list
;

statement:	point
	|	line
	|	circle
	|	rectangle
	|	set_color
	|	END EOS { finish(); }
	|	error {printf("Syntax error\n"); }
;

point: 		POINT INT INT EOS 
		{ point($2,$3); }
;

line:		LINE INT INT INT INT EOS
		{
			if( isValidCoordinate($2, $3) && isValidCoordinate($4, $5) ) {
				line($2,$3,$4,$5);
			} else {
				printf("%s", errmsg);
			}
		}
;

circle:		CIRCLE INT INT INT EOS
		{ 
			if( isValidCircle($2, $3, $4) ) {
				circle($2,$3,$4);
			} else {
				printf("%s", errmsg);
			}
		}
;

rectangle:	RECTANGLE INT INT INT INT EOS 
		{
			if( isValidRect($2, $3, $4, $5) ) {
				rectangle($2,$3,$4,$5);
			} else {
				printf("%s", errmsg);
			}
		}
;

set_color:	SET_COLOR INT INT INT EOS
		{ 
			if( isValidColor($2, $3, $4) ) {
				set_color($2,$3,$4);
			} else {
				printf("%s", errmsg);
			}
		}
;

%%

int main(int argc, char** argv)
{
	setup();
	yyparse();
	return 0;
}

int yyerror(const char *msg) {
	return fprintf (stderr, "YACC: %s\n", msg);
}

int ivc(int c) {
	if(c >= 0 && c <= 256) {
		return 1;
	} else {
		return 0;
	}
}

int isValidColor(int r, int g, int b) {
	if( ivc(r) && ivc(g) && ivc(b) ) {
		return 1;
	} else {
		return 0;
	}
}

int isValidCoordinate(int x, int y) {
	if ( (x >= 0 && x <= 1024) && (y >= 0 && y <= 768) ) {
		return 1;
	} else {
		return 0;
	}
}

int isValidRect(int x, int y, int w, int h) {
	if( isValidCoordinate(x, y) ) {
		int x2 = x + w;
		int y2 = y + h;
		if( isValidCoordinate(x2, y2) ) {
			return 1;
		}
	} else {
		return 0;
	}
}

int isValidCircle(int x, int y, int r) {
	if( isValidCoordinate(x, y) ) {
		if( (x + r <= 1024) + (x - r >= 0) ){
			if( (y + r < 768) && (y - r > 0) ) {
				return 1;
			}
		}
	} else {
		return 0;
	}
}

