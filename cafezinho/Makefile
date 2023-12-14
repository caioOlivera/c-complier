CC = gcc
LEX = flex
YACC = bison
CFLAGS = -Wall -g

cafezinho: lex.yy.c parser.tab.c
	$(CC) $(CFLAGS) -o cafezinho lex.yy.c parser.tab.c -lfl

lex.yy.c: lexer.l parser.tab.c
	$(LEX) lexer.l

parser.tab.c: parser.y
	$(YACC) -d parser.y

clean:
	rm -f cafezinho lex.yy.c parser.tab.c parser.tab.h

