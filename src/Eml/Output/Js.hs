--
-- Max E. Kuznetsov <mek@mek.uz.ua> 2014
--

module Eml.Output.Js 
    (
     JsRenderable,
     render
    )
where

import Text.Printf (printf)
import Data.List (intercalate)

import qualified Eml.Types as T

class JsRenderable a where
    renderJs :: a -> String

instance JsRenderable T.Pair where
    renderJs (T.Pair k v) = k ++ ":" ++ renderJs v

instance JsRenderable T.Value where
    renderJs (T.StringValue v) = v
    renderJs (T.DoubleValue v) = show v
    renderJs (T.ListValue v) = "[" ++ joinList "," (map renderJs v) ++ "]"

instance JsRenderable T.Item where
    renderJs (T.Item name pairs items) = printf tpl name rp ritems
        where
          tpl = "new Euterpe.%s({%s,items=%s})"
          rp = joinList "," $ map renderJs pairs
          ritems = "[" ++ joinList "," (map renderJs items) ++ "]"

joinList = intercalate 

-- Render item
render :: JsRenderable a => a -> String

render item = renderJs item
