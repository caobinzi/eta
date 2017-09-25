{-# LANGUAGE ScopedTypeVariables #-}

import Java
import Spark.Types
import Spark.Methods as S
import System.IO
import System.Environment

main :: IO ()
main =  do
  args <- getArgs
  job $ args !! 0
 
job :: String -> IO ()
job file = 
        java $ do
          io $ putStrLn $ "Load file " ++ file
          conf <- newSparkConf
          conf <.> setAppName "Simple Application"
          sc <- newSparkContext conf
          logData <- sc <.> textFile logfile >- cache
          numAs <- logData <.> S.filter (\(s :: String) -> 'a' `elem` s) >- count
          numBs <- logData <.> S.filter (\(s :: String) -> 'b' `elem` s) >- count
          io $ putStrLn $ "Lines with a: " ++ show numAs
                        ++ ", lines with b: " ++ show numBs
          sc <.> stop
        where logfile = file
 
