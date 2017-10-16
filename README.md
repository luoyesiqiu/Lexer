# CLexer

一个简单的C语言词法分析器，通过JFlex生成。源码中包含jflex文件

> 输入以下的C语言代码：
```
#include <stdio.h>
#define N 63
int main(void)
{
	char c='a';
	printf("%s","Hello");
	return 0;
}
```
> 产生以下结果：
```
(0,PRETREATMENT_LINE,"#include <stdio.h>")
(19,PRETREATMENT_LINE,"#define N 63")
(38,KEYWORD,"int")
(42,IDENTIFIER,"main")
(44,LPAREN,"(")
(56,KEYWORD,"void")
(60,RPAREN,")")
(73,LBRACE,"{")
(88,KEYWORD,"char")
(92,IDENTIFIER,"c")
(94,OPERATOR,"=")
(95,CHARACTER_LITERAL,"a")
(112,SEMICOLON,";")
(121,IDENTIFIER,"printf")
(123,LPAREN,"(")
(135,STRING,"%s")
(153,COMMA,",")
(161,STRING,"Hello")
(179,RPAREN,")")
(192,SEMICOLON,";")
(201,KEYWORD,"return")
(205,INTEGER_LITERAL,"0")
(208,SEMICOLON,";")
(217,RBRACE,"}")
```
