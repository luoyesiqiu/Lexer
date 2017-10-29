package test;

import java.io.FileReader;
import java.io.IOException;

import lexer.CLexer;
import lexer.CType;

public class CLexerTest {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
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
				String target=//cLexer.yytext();
				String.format("(%d,%s,\"%s\",%d)", idx,cType.name(),cLexer.yytext(),len);
				System.out.println(target);
				idx+=len;
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
	}

}
