%{
    #include <stdio.h>
%}
 
%%
 
(END|end)	  			{ exit(0); }
(;)           			{ printf("END_STATEMENT\n"); }
(POINT)					{ printf("POINT\n"); }
(LINE)					{ printf("LINE\n"); }
(CIRCLE)				{ printf("CIRCLE\n"); }
(RECTANGLE)				{ printf("RECTANGLE\n"); }
(SET_COLOR)				{ printf("SET_COLOR"); }
([0-9]+.[0-9]*)			{ printf("FLOAT\n"); }
[0-9]        			{ printf("DIGIT\n"); }
\ |\n          ; // Ignore these chars!
.+						{ printf("BAD_INPUT\n"); }

 
%%
 
int main(int argc, char** argv){
  yylex();    // Start lexing!
  return 0;
}