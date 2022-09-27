%{
    #include<stdio.h>
    extern int yylex();

    void yyerror(char *s); // declaration


%}

%token INT FLOAT ASSIGN EQUAL LPAREN RPAREN LBRACE RBRACE IF WHILE ADD SUB SEMI ID NUM GT

%start start

%%

start:  statement| ;


statement: statement expression| if_statement| while_statement|func_statement| ;

func_statement: statement type ID LPAREN expression RPAREN LBRACE statement RBRACE| ;
if_statement:statement IF LPAREN expression RPAREN LBRACE statement RBRACE;
while_statement:WHILE LPAREN expression RPAREN LBRACE statement RBRACE
        |
        ;
expression: type ID SEMI
        |type ID ASSIGN NUM SEMI
        |type ID ASSIGN ID OP ID SEMI
        |type ID ASSIGN ID OP NUM SEMI
        |ID EQUAL NUM
        |ID GT NUM
        |
        ;
type: INT|FLOAT;
OP: ADD|SUB;

%%

void yyerror(char *s)
{
    fprintf(stderr,"error: %s\n",s);

}

int main()
{
    yyparse();

    printf("Parser is Finished\n");

    return 0;

}