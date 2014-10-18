--
-- Max E. Kuznetsov <mek@mek.uz.ua> 2014
--

module Eml.Types
    (
     Pair(..),
     Item(..),
     Value(..)
    )
where

data Pair = Pair String Value
            deriving (Eq, Show)

data Item = Item String [Pair] [Item]
     deriving (Eq, Show)

data Value = StringValue String |
             DoubleValue Double |
             ListValue [Item]
             deriving (Eq, Show)

