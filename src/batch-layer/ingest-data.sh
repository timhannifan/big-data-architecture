# /bin/bash

echo "Putting to HDFS..."
for name in *.csv
  do hdfs dfs -put $name /inputs/hannifan_project/${name};
done
