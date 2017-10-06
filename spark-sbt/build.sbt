name := "SparkStreaming"

scalaVersion := "2.11.5"

val sparkVersion  = "2.2.0"

libraryDependencies += "org.apache.spark" % "spark-core_2.11" % sparkVersion
libraryDependencies += "org.apache.spark" % "spark-hive_2.11" % sparkVersion
libraryDependencies += "org.apache.spark" % "spark-streaming_2.11" % sparkVersion 
libraryDependencies += "org.apache.spark" % "spark-streaming-kafka-0-10_2.11" % sparkVersion 

