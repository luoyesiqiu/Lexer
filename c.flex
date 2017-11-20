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

%}

/* main character classes */
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteCharacter = [ \t\f]
WhiteSpace = {LineTerminator} | {WhiteCharacter}

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

/* 字符串和字符 */
StringCharacter = [^\r\n\"\\]
SingleCharacter = [^\r\n\'\\]

/*单行预处理*/
PretreatmentLine = #[ ]*(error|else|elif|endif|line|include|pragma)

/*define等多行处理*/

DefineLine = #[ ]*(if|ifdef|ifndef|define|undef)

DefineNewLine = \\

%state STRING, CHARLITERAL,PRETREATMENT,DEFINE,DEFINE_NEW_LINE

%%

<YYINITIAL> {

  
  /*单行预处理*/
  {PretreatmentLine}			 { yybegin(PRETREATMENT);return CType.PRETREATMENT_LINE; }
  
   /*define*/
  {DefineLine}			 		{ { yybegin(DEFINE);return CType.DEFINE_LINE; } }
  
  /* 关键字 */
  "auto"                         { return CType.KEYWORD; }
  "break"                        { return CType.KEYWORD; }
  "case"                         { return CType.KEYWORD; }
  "catch"                        { return CType.KEYWORD; }
  "char"                         { return CType.KEYWORD; }
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
  
  /* 字符串开始 */
   \"                             { yybegin(STRING); return CType.STRING;}

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

  /* 换行符 */
  {LineTerminator}                   { return CType.NEW_LINE; }

    /* 空白符 */
  {WhiteCharacter}                   { return CType.WHITE_CHAR; }
  
  /* 标识符 */ 
  {Identifier}                   { return CType.IDENTIFIER; } 
  
}
/*单行宏*/
<PRETREATMENT>{
	[a-zA-Z0-9_-]					{ return CType.PRETREATMENT_LINE; }
	\"                         		{ return CType.PRETREATMENT_LINE; }
    "<"                            { return CType.PRETREATMENT_LINE; }
    ">"                            { return CType.PRETREATMENT_LINE; }
    "."                            { return CType.PRETREATMENT_LINE; }
	{Comment}						{ yybegin(YYINITIAL);return CType.COMMENT; }
	{LineTerminator} 				{ yybegin(YYINITIAL);return CType.NEW_LINE; }
	{WhiteCharacter}				{ return CType.PRETREATMENT_LINE; }
	"/"                            { return CType.PRETREATMENT_LINE; }/*空格*/
}
/*多行宏*/
<DEFINE>{
	[a-zA-Z0-9_]					{ return CType.DEFINE_LINE; }
	"?"								{ return CType.DEFINE_LINE; }
	"("                          { return CType.DEFINE_LINE; }
  ")"                            { return CType.DEFINE_LINE; }
  "{"                            { return CType.DEFINE_LINE; }
  "}"                            { return CType.DEFINE_LINE; }
  "["                            { return CType.DEFINE_LINE; }
  "]"                            { return CType.DEFINE_LINE; }
  ";"                            { return CType.DEFINE_LINE; }
  ","                            { return CType.DEFINE_LINE; }
  "."                            { return CType.DEFINE_LINE; }
  
  /* 运算符 */
  "="                            { return CType.DEFINE_LINE; }
  ">"                            { return CType.DEFINE_LINE; }
  "<"                            { return CType.DEFINE_LINE; }
  "!"                            { return CType.DEFINE_LINE; }
  "~"                            { return CType.DEFINE_LINE; }
  "?"                            { return CType.DEFINE_LINE; }
  ":"                            { return CType.DEFINE_LINE; }
  "=="                           { return CType.DEFINE_LINE; }
  "<="                           { return CType.DEFINE_LINE; }
  ">="                           { return CType.DEFINE_LINE; }
  "!="                           { return CType.DEFINE_LINE; }
  "&&"                           { return CType.DEFINE_LINE; }
  "||"                           { return CType.DEFINE_LINE; }
  "++"                           { return CType.DEFINE_LINE; }
  "--"                           { return CType.DEFINE_LINE; }
  "+"                            { return CType.DEFINE_LINE; }
  "-"                            { return CType.DEFINE_LINE; }
  "*"                            { return CType.DEFINE_LINE; }
  "/"                            { return CType.DEFINE_LINE; }
  "&"                            { return CType.DEFINE_LINE; }
  "|"                            { return CType.DEFINE_LINE; }
  "^"                            { return CType.DEFINE_LINE; }
  "%"                            { return CType.DEFINE_LINE; }
  "<<"                           { return CType.DEFINE_LINE; }
  ">>"                           { return CType.DEFINE_LINE; }
  "+="                           { return CType.DEFINE_LINE; }
  "-="                           { return CType.DEFINE_LINE; }
  "*="                           { return CType.DEFINE_LINE; }
  "/="                           { return CType.DEFINE_LINE; }
  "&="                           { return CType.DEFINE_LINE; }
  "|="                           { return CType.DEFINE_LINE; }
  "^="                           { return CType.DEFINE_LINE; }
  "%="                           { return CType.DEFINE_LINE; }
  "<<="                          { return CType.DEFINE_LINE; }
  ">>="                          { return CType.DEFINE_LINE; }
  {WhiteCharacter}				{ return CType.DEFINE_LINE; }/*空格*/
  {DefineNewLine}				{ yybegin(DEFINE_NEW_LINE);return CType.DEFINE_LINE; }/*遇到新行，继续*/
  
  {LineTerminator} 				{ yybegin(YYINITIAL);return CType.NEW_LINE; }
  {Comment}						{ yybegin(YYINITIAL);return CType.COMMENT; }
}

/*宏换行时*/
<DEFINE_NEW_LINE>{
	{WhiteCharacter}							{ return CType.DEFINE_LINE; }/*跳回DEFINE状态*/
	{LineTerminator}							{ yybegin(DEFINE);return CType.DEFINE_LINE; }/*跳回DEFINE状态*/
}


<STRING> {
    \"                             { yybegin(YYINITIAL);return CType.STRING;}
  {StringCharacter}+             	{  return CType.STRING;}
  \\.				            	 {  return CType.STRING;}
  {LineTerminator}             	    {yybegin(YYINITIAL);return CType.NEW_LINE;}
}

<CHARLITERAL> {
   \'							{yybegin(YYINITIAL);return CType.CHARACTER_LITERAL;}
  {SingleCharacter}          	{  return CType.CHARACTER_LITERAL; }
   \\.				            {  return CType.CHARACTER_LITERAL;}
  {LineTerminator}               {yybegin(YYINITIAL);return CType.NEW_LINE;}
}

/* error fallback */
[^]                              { throw new RuntimeException("Illegal character \""+yytext()+
                                                              "\" at line "+yyline+", column "+yycolumn); }
<<EOF>>                          { return CType.EOF; }