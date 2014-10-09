--
-- Max E. Kuznetsov <mek@mek.uz.ua> 2014
--

{
module Eml.Input.EmlLex where
}

%wrapper "posn"

$digit = 0-9
$alpha = [a-zA-Z]

tokens :-

       $white+                    ;
       \#.*                       ;
       [\=\.\[\]\,]               { tok (\p s -> Symbol p (head s)) }
       $digit+\.$digit+           { tok (\p s -> Number p (read s)) }
       $digit+                    { tok (\p s -> Number p (read s)) }
       $alpha [$alpha $digit \_]* { tok (\p s -> Id p s) }
       \" ($printable # \")* \"   { tok (\p s -> StrLiteral p s) }
       \' ($printable # \')* \'   { tok (\p s -> StrLiteral p s)}

{

tok f p s = f p s

data Token = Symbol AlexPosn Char   |
             Number AlexPosn Double |
             Id AlexPosn String     |
             StrLiteral AlexPosn String
             deriving (Eq, Show)

token_posn (Symbol p _) = p
token_posn (Number p _) = p
token_posn (Id p _) = p
token_posn (StrLiteral p _) = p

}

