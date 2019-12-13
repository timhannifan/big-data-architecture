# /bin/bash

echo "Putting to HDFS..."
hdfs dfs -mkdir /inputs/hannifan_project;
for name in *.csv
  do hdfs dfs -put $name /inputs/hannifan_project/${name};
done
