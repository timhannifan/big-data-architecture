echo "Started serving layer hive scripts"
hive -f orc-to-hbase.hql
echo "Completed serving layer"