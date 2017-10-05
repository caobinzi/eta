{-# LANGUAGE NoImplicitPrelude, FlexibleContexts, MultiParamTypeClasses, FlexibleInstances #-}
module Spark.Methods where

import Prelude hiding (filter)
import Spark.Types
import Data.Int
import Java hiding (JavaConverter)

type Spark a = Java JavaSparkContext a
type RDD a b = Java (JavaRDD a) b

--Spark Conf
foreign import java unsafe "@new" newSparkConf :: Java c SparkConf
foreign import java unsafe "setAppName"
  setAppName :: String -> Java SparkConf SparkConf

foreign import java unsafe "setMaster"
  setMaster :: String -> Java SparkConf SparkConf

foreign import java unsafe "set" 
  set :: String -> String -> Java SparkConf SparkConf

--Spark Context
foreign import java unsafe "@new"
  newSparkContext :: SparkConf -> Java a JavaSparkContext


--Spark Context
foreign import java unsafe "@new"
  newDuration ::  Int64 -> Java a Duration


--Spark Context
foreign import java unsafe "@new"
  newStreamingContext :: JavaSparkContext -> Duration -> Java a JavaStreamingContext

foreign import java unsafe "start" startStreaming ::  Java JavaStreamingContext ()
foreign import java unsafe awaitTermination  ::  Java JavaStreamingContext ()

--RDD
foreign import java unsafe "textFile" textFile :: String -> Spark (JavaRDD JString)
foreign import java unsafe stop :: Spark ()
foreign import java unsafe cache :: (Extends t Object) => RDD t (JavaRDD t)
foreign import java safe count :: (Extends t Object) => RDD t Int64

foreign import java unsafe "@wrapper call"
  fun :: (Extends t1 Object, Extends r Object)
      => (t1 -> Java (Function t1 r) r) -> Function t1 r

foreign import java safe "filter"
  filter' :: (Extends t Object) => Function t Boolean -> RDD t (JavaRDD t)

foreign import java unsafe "@static @field java.lang.Boolean.TRUE"
  tRUE :: Boolean
foreign import java unsafe "@static @field java.lang.Boolean.FALSE"
  fALSE :: Boolean

filter :: (Extends t Object, JavaConverter b t, JavaConverter c Boolean)
       => (b -> c) -> RDD t (JavaRDD t)
filter f = filter' (fun (\t -> return $ jconvert (f (jconvertReverse t))))

class JavaConverter a b where
  jconvert :: a -> b
  jconvertReverse :: b -> a

instance JavaConverter String JString where
  jconvert = toJString
  jconvertReverse = fromJString

instance JavaConverter Bool Boolean where
  jconvert True = tRUE
  jconvert False = fALSE
  jconvertReverse = equals tRUE
