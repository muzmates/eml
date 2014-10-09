--
-- Max E. Kuznetsov <mek@mek.uz.ua> 2014
--

import Eml.Input.EmlLex
import Eml.Input.EmlSyn

main = do
     s <- getContents

     print $ parse $ alexScanTokens s
