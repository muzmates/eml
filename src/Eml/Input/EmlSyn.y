--
-- Max E. Kuznetsov <mek@mek.uz.ua> 2014
--

{
module Eml.Input.EmlSyn where

import Text.Printf
import Eml.Types
import Eml.Input.EmlLex (token_posn, Token(..), AlexPosn(..))
}

%name parse
%tokentype { Token }

%error { parseError }

%token
       '='       { Symbol _ '=' }
       '['       { Symbol _ '[' }
       ']'       { Symbol _ ']' }
       ';'       { Symbol _ ';' }
        number   { Number _ $$ }
        id       { Id _ $$ }
        string   { StrLiteral _ $$ }

%%

Item     : id Attrs Children      { Item $1 $2 $3 }
Attrs    : {- empty -}            { [] }
         | Pair Attrs             { $1 : $2 }
Pair     : id '=' Value           { Pair $1 $3 }
Value    : number                 { DoubleValue $1 }
         | string                 { StringValue $1 }
         | Children               { ListValue $1 }
Children : ';'                    { [] }
         | '[' ChildExp ']'       { $2 }
ChildExp : {- empty -}            { [] }
ChildExp : Item ChildExp          { $1 : $2 }

{

parseError :: [Token] -> a
parseError t = error $ errMsg (line pos) (col pos)
               where
                 first = head t
                 pos = token_posn first

line (AlexPn _ line _) = line
col (AlexPn _ _ col) = col

errMsg :: Int -> Int -> String
errMsg line col = "Parse error: " ++ (show line) ++ ":" ++ (show col)

}
