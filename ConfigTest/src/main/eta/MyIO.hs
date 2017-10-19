{-# LANGUAGE OverloadedStrings #-}

module MyIO where

import Data.Config
import Data.Text (Text)

data Foo = Foo { fooPort :: Integer, fooAddr :: Text } deriving Show

main :: IO ()
main = do
  foo <- loadFooProps
  putStrLn $ (show foo)
  where
    loadFooProps = do
      config <- loadConfig "app.conf"
      port   <- getInteger "foo.port" config
      addr   <- getString "foo.addr" config
      return (Foo port addr)

foreign export java "@static eta.MyIO.test"
  main :: IO ()
