
module Example.MyIO where

import Java

import Control.Lens
import Data.Aeson
import Data.Aeson.Lens
import Data.Text (Text)
import qualified Data.Text as T

main :: IO ()
main = putStrLn "haha"
foreign export java "@static eta.example.MyIO.test"
  main :: IO ()
