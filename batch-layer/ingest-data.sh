for name in *.csv
  do hdfs dfs -put $name /inputs/hannifan_project/${name};
done
