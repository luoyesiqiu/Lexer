# CLexer

一个简单的C语言词法分析器，通过JFlex生成。源码中包含jflex文件

> 输入以下的C语言代码：
```
 #define MAX(a,b)\
 ((a)>(b))?(a):(b);
 #else /*Hello*/
 #include <stdio.h>
/*A c language demo*/
int main(void)
{

	char c='\0';
	printf("Hello\0");
	return 0x0;
}
```
> 产生以下结果：
```
(0,DEFINE_LINE," #define MAX(a,b)\
 ((a)>(b))?(a):(b);",39)
(39,WHITE_SPACE,"
",2)
(41,PRETREATMENT_LINE," #else ",7)
(48,COMMENT,"/*Hello*/",9)
(57,WHITE_SPACE,"
",2)
(59,PRETREATMENT_LINE," #include <stdio.h>",19)
(78,WHITE_SPACE,"
",2)
(80,COMMENT,"/*A c language demo*/",21)
(101,WHITE_SPACE,"
",2)
(103,KEYWORD,"int",3)
(106,WHITE_SPACE," ",1)
(107,IDENTIFIER,"main",4)
(111,LPAREN,"(",1)
(112,KEYWORD,"void",4)
(116,RPAREN,")",1)
(117,WHITE_SPACE,"
",2)
(119,LBRACE,"{",1)
(120,WHITE_SPACE,"
",2)
(122,WHITE_SPACE,"
",2)
(124,WHITE_SPACE,"	",1)
(125,KEYWORD,"char",4)
(129,WHITE_SPACE," ",1)
(130,IDENTIFIER,"c",1)
(131,OPERATOR,"=",1)
(132,CHARACTER_LITERAL,"'",1)
(133,CHARACTER_LITERAL,"\0",2)
(135,CHARACTER_LITERAL,"'",1)
(136,SEMICOLON,";",1)
(137,WHITE_SPACE,"
",2)
(139,WHITE_SPACE,"	",1)
(140,IDENTIFIER,"printf",6)
(146,LPAREN,"(",1)
(147,STRING,""",1)
(148,STRING,"Hello",5)
(153,STRING,"\0",2)
(155,STRING,""",1)
(156,RPAREN,")",1)
(157,SEMICOLON,";",1)
(158,WHITE_SPACE,"
",2)
(160,WHITE_SPACE,"	",1)
(161,KEYWORD,"return",6)
(167,WHITE_SPACE," ",1)
(168,INTEGER_LITERAL,"0x0",3)
(171,SEMICOLON,";",1)
(172,WHITE_SPACE,"
",2)
(174,RBRACE,"}",1)
```
