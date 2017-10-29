package test;

import java.io.FileNotFoundException;
import java.io.FileReader;

import lexer.JavaScriptLexer;
import lexer.JavaScriptType;

public class JSLexerTest {

	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		FileReader fileReader=new FileReader("jflexTest.js");
		JavaScriptLexer lexer=new JavaScriptLexer(fileReader);
		int idx=0;
		while (true) {
			try
			{
				JavaScriptType type=lexer.yylex();
				if(type==JavaScriptType.EOF)
				{
					break;
				}
				//这里输出三个数据
				//1.状态的位置
				//2.状态的名称
				//3.状态的内容
				//4.内容的长度
				int len=lexer.yytext().length();
				String target=//cLexer.yytext();
				String.format("(%d,%s,\"%s\",%d)", idx,type.name(),lexer.yytext(),len);
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
