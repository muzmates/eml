--
-- Max E. Kuznetsov <mek@mek.uz.ua> 2014
--

import Eml.Input.EmlLex (alexScanTokens)
import Eml.Input.EmlSyn (parse)
import Eml.Output.Js (render)

main = do
     s <- getContents

     putStrLn . render . parse $ alexScanTokens s
