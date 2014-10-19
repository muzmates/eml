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
    renderJs (T.Item name [] []) = printf tpl name
        where
          tpl = "new Euterpe.%s({})"

    renderJs (T.Item name [] items) = printf tpl name (renderItems items)
        where
          tpl = "new Euterpe.%s({items:%s})"

    renderJs (T.Item name pairs []) = printf tpl name (renderPairs pairs)
        where
          tpl = "new Euterpe.%s({%s})"

    renderJs (T.Item name pairs items) = printf tpl name rp ritems
        where
          tpl = "new Euterpe.%s({%s,items:%s})"
          rp = renderPairs pairs
          ritems = renderItems items

renderPairs pairs = joinList "," $ map renderJs pairs
renderItems items = "[" ++ joinList "," (map renderJs items) ++ "]"
joinList = intercalate 

-- Render item
render :: JsRenderable a => a -> String

render item = printf tpl (renderJs item)
    where
      tpl = "function renderScore(width, scale, x, y, canvasId) {var root=%s;\
            \var stage=Euterpe.render(root,x,y,width,scale,canvasId);\
            \stage.draw();};"
