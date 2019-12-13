-- This file will generate a HBase table for serving the twosides data

drop table if exists hannifan_interactions;
CREATE EXTERNAL TABLE hannifan_interactions (
  drug_1_name string,
  drug_2_name string,
  condition_name string,
  A smallint,
  B smallint,
  C smallint,
  D smallint,
  prr string,
  prr_err string,
  mean_reporting_frequency float)
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ('hbase.columns.mapping' = ':key,interactions:drug_2_name,interactions:condition_name,interactions:A,interactions:B,interactions:C,interactions:D,interactions:prr,interactions:prr_err,interactions:mean_reporting_frequency')
TBLPROPERTIES ('hbase.table.name' = 'hannifan_final');

insert overwrite table hannifan_interactions
select drug_1_name,
  drug_2_name,
  condition_name,
  A,
  B,
  C,
  D,
  prr,
  prr_err,
  mean_reporting_frequency from twosides;


  -- Run a test query to make sure the data was successfully stored

select * from hannifan_interactions limit 5;