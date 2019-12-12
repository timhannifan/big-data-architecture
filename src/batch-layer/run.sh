# /bin/bash

echo "Started batch layer ingestion"
sh get-data.sh
sh extract-data.sh
sh ingest-data.sh
echo "Completed batch ingestion"

echo "Started batch layer Hive scripts"
hive -f hive/csv-to-hive.hql
hive -f hive/hive-to-orc.hql
echo "Completed batch layer Hive scripts"