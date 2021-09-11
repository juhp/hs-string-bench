-- SPDX-License-Identifier: BSD-3-Clause

module Main (main) where

import Control.Monad
import qualified Data.ByteString as B
import qualified Data.ByteString.Internal as B
import qualified Data.ByteString.Char8 as B8
import qualified Data.List as L
import qualified Data.Text as T
import qualified Data.Text.IO as T
import qualified Data.Text.Lazy as TL
import qualified Data.Text.Lazy.IO as TL
import Test.Tasty.Bench

main :: IO ()
main = defaultMain
  [ bgroup (show needle ++ " in " ++ file)
    [ bench "Data.String"           $ nfIO $ stringSearch needle file
    , bench "Data.Text"             $ nfIO $ textSearch needle file
    , bench "Data.Text.Lazy"        $ nfIO $ textLazySearch needle file
    , bench "Data.ByteString"       $ nfIO $ bytestringSearch needle file
    , bench "Data.ByteString.Char8" $ nfIO $ bytestringChar8Search needle file
    ] | file <- ["data/toolbox.spec", "data/lorem-ipsum"], needle <- ["%gometa","dolorum"]]

stringSearch :: String -> FilePath -> IO ()
stringSearch needle file = do
  contents <- readFile file
  when (needle `L.isInfixOf` contents) $
    return ()

textSearch :: String -> FilePath -> IO ()
textSearch needle file = do
  contents <- T.readFile file
  when (T.pack needle `T.isInfixOf` contents) $
    return ()

textLazySearch :: String -> FilePath -> IO ()
textLazySearch needle file = do
  contents <- TL.readFile file
  when (TL.pack needle `TL.isInfixOf` contents) $
    return ()

bytestringSearch :: String -> FilePath -> IO ()
bytestringSearch needle file = do
  contents <- B.readFile file
  when (B.pack (map B.c2w needle) `B.isInfixOf` contents) $
    return ()

bytestringChar8Search :: String -> FilePath -> IO ()
bytestringChar8Search needle file = do
  contents <- B8.readFile file
  when (B8.pack needle `B8.isInfixOf` contents) $
    return ()
