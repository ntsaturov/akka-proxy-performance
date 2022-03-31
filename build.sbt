import Dependencies._

ThisBuild / scalaVersion     := "2.13.8"
ThisBuild / organization     := "com.proxy"

lazy val root = (project in file("."))
  .settings(
    name := "proxy-performance",
    libraryDependencies += scalaTest % Test
  )
