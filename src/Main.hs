--
-- Max E. Kuznetsov <mek@mek.uz.ua> 2014
--

import System.Environment (getArgs)
import Eml.Input.EmlLex (alexScanTokens)
import Eml.Input.EmlSyn (parse)
import Eml.Output.Js (render)

usage = error "Usage: eml inputFile.eml [outputFile.js]"

main = do
  args <- getArgs

  case args of
    [input] ->
        do
          s <- readFile input
          putStrLn $ process s
    [input, output] ->
        do
          s <- readFile input
          writeFile output $ process s
    _ ->
        usage

process = render . parse . alexScanTokens
