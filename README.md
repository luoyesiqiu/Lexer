# CLexer

一个简单的C语言词法分析器，通过JFlex生成。源码中包含jflex文件

> 输入以下的C语言代码：
```
#define N 10
/*A c language demo*/
int main(void)
{

	char c='\0';
	printf("Hello\n");
	return 0;
}
```
> 产生以下结果：
```
(0,PRETREATMENT_LINE,"#define N 10",12)
(12,SPACE,"
",2)
(14,COMMENT,"/*A c language demo*/",21)
(35,SPACE,"
",2)
(37,KEYWORD,"int",3)
(40,SPACE," ",1)
(41,IDENTIFIER,"main",4)
(45,LPAREN,"(",1)
(46,KEYWORD,"void",4)
(50,RPAREN,")",1)
(51,SPACE,"
",2)
(53,LBRACE,"{",1)
(54,SPACE,"
",2)
(56,SPACE,"
",2)
(58,SPACE,"	",1)
(59,KEYWORD,"char",4)
(63,SPACE," ",1)
(64,IDENTIFIER,"c",1)
(65,OPERATOR,"=",1)
(66,CHARACTER_LITERAL,"'",1)
(67,CHARACTER_LITERAL,"\0",2)
(69,CHARACTER_LITERAL,"'",1)
(70,SEMICOLON,";",1)
(71,SPACE,"
",2)
(73,SPACE,"	",1)
(74,IDENTIFIER,"printf",6)
(80,LPAREN,"(",1)
(81,STRING,""",1)
(82,STRING,"Hello",5)
(87,STRING,"\n",2)
(89,STRING,""",1)
(90,RPAREN,")",1)
(91,SEMICOLON,";",1)
(92,SPACE,"
",2)
(94,SPACE,"	",1)
(95,KEYWORD,"return",6)
(101,SPACE," ",1)
(102,INTEGER_LITERAL,"0",1)
(103,SEMICOLON,";",1)
(104,SPACE,"
",2)
(106,RBRACE,"}",1)
```
