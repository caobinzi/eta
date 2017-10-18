package example

import java.io.File
import java.io.PrintWriter
import scala.io.Source

import eta.example.Transform
import eta.example.MyIO

object Main extends App {
  val writer = new PrintWriter(new File("output.json"))

  Source.fromFile("data.json").getLines.foreach { json =>
    println(Transform.fixJson(json) ++ "\n")
    println(s"Length = ${Transform.fixlength(json)}")
  }
  writer.close()
  MyIO.test()
}
