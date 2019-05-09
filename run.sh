#!/bin/bash
#---------------------------------------------------------------------------------------#
if [ -z "$1" ]; then

  echo "+-----------------------------------------------+"
  echo "|  0. Build                                     |"
  echo "|  1. Total Links                               |"
  echo "|  2. Export Target Urls                        |"
  echo "|  3. Reading File                              |"
  echo "|  4. Export Health Links                       |"
  echo "+-----------------------------------------------+"

#---------------------------------------------------------------------------------------#
elif [ "$1" == "0" ]; then
    # sbt compile
    sbt clean package
    # sbt assembly 


#---------------------------------------------------------------------------------------#
elif [ "$1" == "1" ]; then
spark-submit    \
  --class "Links"           \
  --master local[16]        \
  --driver-memory   32G     \
  --executor-memory 32G     \
  target/scala-2.11/spark-cassandra-count_2.11-1.0.jar  


#---------------------------------------------------------------------------------------#
elif [ "$1" == "2" ]; then
spark-submit    \
  --class "ExportTargetUrls"    \
  --master local[16]            \
  --driver-memory   32G         \
  --executor-memory 32G         \
  target/scala-2.11/spark-cassandra-count_2.11-1.0.jar links1   \
  data/target.dat 

  
#---------------------------------------------------------------------------------------#
elif [ "$1" == "3" ]; then
spark-submit    \
  --class "Files"           \
  --master local[16]        \
  --driver-memory   32G     \
  --executor-memory 32G     \
  target/scala-2.11/spark-cassandra-count_2.11-1.0.jar  \
  data/diseases.dat 

#---------------------------------------------------------------------------------------#
elif [ "$1" == "4" ]; then
spark-submit    \
  --class "ExportLinks"     \
  --master local[16]        \
  --driver-memory   32G     \
  --executor-memory 32G     \
  target/scala-2.11/spark-cassandra-count_2.11-1.0.jar links1   \
  data/health1.dat 

fi
#---------------------------------------------------------------------------------------#

