# Lexer

简单词法分析器，由Jflex生成。

包含以下下编程语言的词法分析器：
* C
* C++
* Java
* JavaScript


xxLexer.java是词法分析器类。假如使用c语言词法分析器，调用方法如下：

```
FileReader fileReader=new FileReader("jflexTest.c");
CLexer cLexer=new CLexer(fileReader);
int idx=0;
while (true) {
	try
	{
		CType cType=cLexer.yylex();
		if(cType==CType.EOF)
		{
			break;
		}
		//这里输出三个数据
		//1.状态的位置
		//2.状态的名称
		//3.状态的内容
		//4.内容的长度
		int len=cLexer.yytext().length();
		String target=String.format("(%d,%s,\"%s\",%d)", idx,cType.name(),cLexer.yytext(),len);
		System.out.println(target);
		idx+=len;
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
}
```
xxLexer成员解释：
* xxLexer(Reader reader) 从Reader构造一个词法分析器对象
* yylex()  得到下一个词法分析器状态
* yytext()	返回当前状态所匹配的文本