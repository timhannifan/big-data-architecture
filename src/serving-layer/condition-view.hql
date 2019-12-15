-- This file will generate a HBase table for viewing by condition

drop table if exists twosides_conditions;
CREATE EXTERNAL TABLE twosides_conditions (
  condition_key string,
  condition_name string,
  count integer,
  mean_prr float,
  mean_prr_err float,
  mean_reporting_frequency float)
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ('hbase.columns.mapping' = ':key,c:condition_name,c:count, c:mean_prr,c:mean_prr_err,c:mean_reporting_frequency')
TBLPROPERTIES ('hbase.table.name' = 'twosides_conditions');

insert overwrite table twosides_conditions
select 
  condition_name,
  condition_name,
  count(*) count,
  avg(prr),
  avg(prr_err),
  avg(mean_reporting_frequency)
  from twosides
  group by condition_name;

-- Run a test query to make sure the data was successfully stored

select * from twosides_conditions limit 5;