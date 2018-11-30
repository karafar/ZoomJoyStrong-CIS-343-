%{
/*
	Farid Karadsheh
	Prof. Woodring
	GVSU CIS343
	11/30/2018

	Contains the rules for all available lexemes.
*/
	#include <stdlib.h>
	#include "zoomjoystrong.tab.h"

%}


%%
END|end			{ return END; }
;			{ return EOS; }
POINT|point		{ return POINT; }
LINE|line		{ return LINE; }
CIRCLE|circle		{ return CIRCLE; }
RECTANGLE|rectangle	{ return RECTANGLE; }
SET_COLOR|set_color	{ return SET_COLOR; }
[0-9]+			{ yylval.iVal = atoi(yytext); return INT; }	
%%
