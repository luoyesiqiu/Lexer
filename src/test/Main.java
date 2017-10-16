package test;

import java.io.FileReader;
import java.io.IOException;

import lexer.CLexer;
import lexer.CType;

public class Main {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		FileReader fileReader=new FileReader("jflexTest.c");
		CLexer cLexer=new CLexer(fileReader);
		int idx=0;
		while (true) {
			CType cType=cLexer.yylex();
			if(cType==CType.EOF)
			{
				break;
			}
			//这里输出三个数据
			//1.状态的位置
			//2.状态的名称
			//3.状态的内容
			String target=String.format("(%d,%s,\"%s\")", idx,cType.name(),cLexer.yytext());
			System.out.println(target);
			idx+=cType.ordinal();//ordinal返回状态内容的长度
			
		}
	}

}
