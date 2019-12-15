echo "Started serving layer hive scripts"
hive -f orc-to-hbase.hql
hive -f condtion-view.hql
echo "Completed serving layer"