{-# LANGUAGE ScopedTypeVariables #-}

import Java
import Spark.Types
import Spark.Methods as S
import System.IO
import System.Environment

main :: IO ()
main = java $ do
          args <- io getArgs
          let file = args !! 0
          io $ putStrLn $ "Load file " ++ file
          conf <- newSparkConf
          conf <.> setAppName "Simple Application"
          conf <.> setMaster "local[4]"
          sc <- newSparkContext conf
          duration <- newDuration 20000
          ssc <- newStreamingContext sc duration
          logData <- sc <.> textFile file >- cache
          numAs <- logData <.> S.filter (\(s :: String) -> 'a' `elem` s) >- count
          numBs <- logData <.> S.filter (\(s :: String) -> 'b' `elem` s) >- count
          io $ putStrLn $ "Lines with a: " ++ show numAs
                        ++ ", lines with b: " ++ show numBs
          ssc <.> startStreaming
          ssc <.> awaitTermination
          sc <.> stop
 
