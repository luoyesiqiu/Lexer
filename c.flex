/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Copyright (C) 1998-2015  Gerwin Klein <lsf@jflex.de>                    *
 * All rights reserved.                                                    *
 *                                                                         *
 * License: BSD                                                            *
 *                                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/* Java 1.2 language lexer specification */

/* Use together with unicode.flex for Unicode preprocesssing */
/* and java12.cup for a Java 1.2 parser                      */

/* Note that this lexer specification is not tuned for speed.
   It is in fact quite slow on integer and floating point literals, 
   because the input is read twice and the methods used to parse
   the numbers are not very fast. 
   For a production quality application (e.g. a Java compiler) 
   this could be optimized */


package lexer;

%%

%public
%class CLexer

%unicode

%line
%column
%char
%type CType

%{
	/*StringBuilder暂时没用*/
  StringBuilder string = new StringBuilder();
  

  /** 
   * assumes correct representation of a long value for 
   * specified radix in scanner buffer from <code>start</code> 
   * to <code>end</code> 
   */
  private long parseLong(int start, int end, int radix) {
    long result = 0;
    long digit;

    for (int i = start; i < end; i++) {
      digit  = Character.digit(yycharat(i),radix);
      result*= radix;
      result+= digit;
    }

    return result;
  }
%}

/* main character classes */
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]

WhiteSpace = {LineTerminator} | [ \t\f]

/* 注释 */
Comment = {TraditionalComment} | {EndOfLineComment} | 
          {DocumentationComment}

TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/*" "*"+ [^/*] ~"*/"

/* 标识符 */
Identifier = [:jletter:][:jletterdigit:]*

/* 整数 */
DecIntegerLiteral = 0 | [1-9][0-9]*
DecLongLiteral    = {DecIntegerLiteral} [lL]

HexIntegerLiteral = 0 [xX] 0* {HexDigit} {1,8}
HexLongLiteral    = 0 [xX] 0* {HexDigit} {1,16} [lL]
HexDigit          = [0-9a-fA-F]

OctIntegerLiteral = 0+ [1-3]? {OctDigit} {1,15}
OctLongLiteral    = 0+ 1? {OctDigit} {1,21} [lL]
OctDigit          = [0-7]
    
/* 浮点数 */        
FloatLiteral  = ({FLit1}|{FLit2}|{FLit3}) {Exponent}? [fF]
DoubleLiteral = ({FLit1}|{FLit2}|{FLit3}) {Exponent}?

FLit1    = [0-9]+ \. [0-9]* 
FLit2    = \. [0-9]+ 
FLit3    = [0-9]+ 
Exponent = [eE] [+-]? [0-9]+

/* string and character literals */
StringCharacter = [^\r\n\"\\]
SingleCharacter = [^\r\n\'\\]
PretreatmentLine = #[^\r\n]+

%state STRING, CHARLITERAL

%%

<YYINITIAL> {

  /* 关键字 */
  "auto"                         { return CType.KEYWORD; }
  "break"                        { return CType.KEYWORD; }
  "case"                         { return CType.KEYWORD; }
  "catch"                        { return CType.KEYWORD; }
  "char"                         { return CType.KEYWORD; }
  "class"                        { return CType.KEYWORD; }
  "const"                        { return CType.KEYWORD; }
  "continue"                     { return CType.KEYWORD; }
  "default"                      { return CType.KEYWORD; }
  "do"                           { return CType.KEYWORD; }
  "double"                       { return CType.KEYWORD; }
  "else"                         { return CType.KEYWORD; }
  "extern"						 { return CType.KEYWORD; }
  "enum"						 { return CType.KEYWORD; }
  "float"                        { return CType.KEYWORD; }
  "for"                          { return CType.KEYWORD; }

  "long"                         { return CType.KEYWORD; }
  "goto"                         { return CType.KEYWORD; }
  "if"                           { return CType.KEYWORD; }
  "int"                          { return CType.KEYWORD; }
  "include"                      { return CType.KEYWORD; }
  "return"                       { return CType.KEYWORD; }
  "register"                     { return CType.KEYWORD; }
  "short"                        { return CType.KEYWORD; }
  "switch"                       { return CType.KEYWORD; }
  "static"                       { return CType.KEYWORD; }
  "signed"                       { return CType.KEYWORD; }
  "struct"                       { return CType.KEYWORD; }
  "sizeof"                       { return CType.KEYWORD; }
  "typedef"                      { return CType.KEYWORD; }
  "unsigned"                     { return CType.KEYWORD; }
  "union"                     	 { return CType.KEYWORD; }
  "void"                         { return CType.KEYWORD; }
  "while"                        { return CType.KEYWORD; }
  
  /* 分隔符 */
  "("                            { return CType.LPAREN; }
  ")"                            { return CType.RPAREN; }
  "{"                            { return CType.LBRACE; }
  "}"                            { return CType.RBRACE; }
  "["                            { return CType.LBRACK; }
  "]"                            { return CType.RBRACK; }
  ";"                            { return CType.SEMICOLON; }
  ","                            { return CType.COMMA; }
  "."                            { return CType.DOT; }
  
  /* 运算符 */
  "="                            { return CType.OPERATOR; }
  ">"                            { return CType.OPERATOR; }
  "<"                            { return CType.OPERATOR; }
  "!"                            { return CType.OPERATOR; }
  "~"                            { return CType.OPERATOR; }
  "?"                            { return CType.OPERATOR; }
  ":"                            { return CType.OPERATOR; }
  "=="                           { return CType.OPERATOR; }
  "<="                           { return CType.OPERATOR; }
  ">="                           { return CType.OPERATOR; }
  "!="                           { return CType.OPERATOR; }
  "&&"                           { return CType.OPERATOR; }
  "||"                           { return CType.OPERATOR; }
  "++"                           { return CType.OPERATOR; }
  "--"                           { return CType.OPERATOR; }
  "+"                            { return CType.OPERATOR; }
  "-"                            { return CType.OPERATOR; }
  "*"                            { return CType.OPERATOR; }
  "/"                            { return CType.OPERATOR; }
  "&"                            { return CType.OPERATOR; }
  "|"                            { return CType.OPERATOR; }
  "^"                            { return CType.OPERATOR; }
  "%"                            { return CType.OPERATOR; }
  "<<"                           { return CType.OPERATOR; }
  ">>"                           { return CType.OPERATOR; }
  ">>>"                          { return CType.OPERATOR; }
  "+="                           { return CType.OPERATOR; }
  "-="                           { return CType.OPERATOR; }
  "*="                           { return CType.OPERATOR; }
  "/="                           { return CType.OPERATOR; }
  "&="                           { return CType.OPERATOR; }
  "|="                           { return CType.OPERATOR; }
  "^="                           { return CType.OPERATOR; }
  "%="                           { return CType.OPERATOR; }
  "<<="                          { return CType.OPERATOR; }
  ">>="                          { return CType.OPERATOR; }
  ">>>="                         { return CType.OPERATOR; }
  
  /* 字符串 */
   \"                             { yybegin(STRING);string.setLength(0);string.append('\"'); return CType.STRING;}

  /* 字符 */
  \'                             { yybegin(CHARLITERAL);return CType.CHARACTER_LITERAL; }

  /* numeric literals */

  /* This is matched together with the minus, because the number is too big to 
     be represented by a positive integer. */
  
  {DecIntegerLiteral}            { return CType.INTEGER_LITERAL; }
  {DecLongLiteral}               { return CType.INTEGER_LITERAL; }
  
  {HexIntegerLiteral}            { return CType.INTEGER_LITERAL; }
  {HexLongLiteral}               { return CType.INTEGER_LITERAL; }
 
  {OctIntegerLiteral}            { return CType.INTEGER_LITERAL; }  
  {OctLongLiteral}               { return CType.INTEGER_LITERAL; }
  
  {FloatLiteral}                 { return CType.FLOATING_POINT_LITERAL; }
  {DoubleLiteral}                { return CType.FLOATING_POINT_LITERAL; }
  {DoubleLiteral}[dD]            { return CType.FLOATING_POINT_LITERAL; }
  
  /* comments */
  {Comment}                      { return CType.COMMENT; }

  /* 空白符 */
  {WhiteSpace}                   { return CType.SPACE; }

  /* 标识符 */ 
  {Identifier}                   { return CType.IDENTIFIER; }  
  {PretreatmentLine}					 { return CType.PRETREATMENT_LINE; }
}


<STRING> {
    \"                             { yybegin(YYINITIAL);return CType.STRING;}
  
  {StringCharacter}+             { string.append( yytext() ); string.append('\"'); return CType.STRING;}
  
  /* escape sequences */
  "\\b"                          { string.append( '\b' );return CType.STRING; }
  "\\t"                          { string.append( '\t' ); return CType.STRING;}
  "\\n"                          { string.append( '\n' ); return CType.STRING;}
  "\\f"                          { string.append( '\f' ); return CType.STRING;}
  "\\r"                          { string.append( '\r' ); return CType.STRING;}
  "\\\""                         { string.append( '\"' ); return CType.STRING;}
  "\\'"                          { string.append( '\'' ); return CType.STRING;}
  "\\\\"                         { string.append( '\\' ); return CType.STRING;}
  

  /* error cases */
  \\.                            { throw new RuntimeException("Illegal escape sequence \""+yytext()+"\""); }
  {LineTerminator}               { throw new RuntimeException("Unterminated string at end of line"); }
}

<CHARLITERAL> {
   \'							{yybegin(YYINITIAL);return CType.CHARACTER_LITERAL;}
  {SingleCharacter}          {  return CType.CHARACTER_LITERAL; }
  
  /* escape sequences */
  "\\b"                        {  return CType.CHARACTER_LITERAL;}
  "\\t"                        {  return CType.CHARACTER_LITERAL;}
  "\\n"                        {  return CType.CHARACTER_LITERAL;}
  "\\f"                        {  return CType.CHARACTER_LITERAL;}
  "\\r"                        {  return CType.CHARACTER_LITERAL;}
  "\\\""                       {  return CType.CHARACTER_LITERAL;}
  "\\'"                        {  return CType.CHARACTER_LITERAL;}
  "\\\\"                       {  return CType.CHARACTER_LITERAL;}
  \\[0-9]                       {  return CType.CHARACTER_LITERAL;}
  /* error cases */
  \\.                            { throw new RuntimeException("Illegal escape sequence \""+yytext()+"\""); }
  {LineTerminator}               { throw new RuntimeException("Unterminated character literal at end of line"); }
}

/* error fallback */
[^]                              { throw new RuntimeException("Illegal character \""+yytext()+
                                                              "\" at line "+yyline+", column "+yycolumn); }
<<EOF>>                          { return CType.EOF; }