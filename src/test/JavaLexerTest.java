package test;

import java.io.FileReader;
import java.io.IOException;

import lexer.CLexer;
import lexer.CType;
import lexer.JavaLexer;
import lexer.JavaType;

public class JavaLexerTest {

	public static void main(String[] args) throws IOException{
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		FileReader fileReader=new FileReader("jflexTest.java");
		JavaLexer javaLexer=new JavaLexer(fileReader);
		int idx=0;
		while (true) {
			try
			{
				JavaType javaType=javaLexer.yylex();
				if(javaType==JavaType.EOF)
				{
					break;
				}
				//这里输出三个数据
				//1.状态的位置
				//2.状态的名称
				//3.状态的内容
				//4.内容的长度
				int len=javaLexer.yytext().length();
				String target=String.format("(%d,%s,\"%s\",%d)", idx,javaType.name(),javaLexer.yytext(),len);
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
