drop table if exists hannifan_interactions_hive;
create table hannifan_interactions_hive (
  drug_1_id smallint,
  drug_1_name string,
  drug_2_id smallint,
  drug_2_name string,
  condition_id smallint,
  condition_name string,
  A smallint,
  B smallint,
  C smallint,
  D smallint,
  prr string,
  prr_err string,
  mean_reporting_frequency float)
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ('hbase.columns.mapping' = ':key,hannifan_interactions:row,hannifan_interactions:drug_1_id,hannifan_interactions:drug_1_name,hannifan_interactions:drug_2_id,hannifan_interactions:drug_2_name,hannifan_interactions:condition_id,hannifan_interactions:condition_name,hannifan_interactions:A,hannifan_interactions:B,hannifan_interactions:C,hannifan_interactions:D,hannifan_interactions:prr,hannifan_interactions:prr_err,hannifan_interactions:mean_reporting_frequency')
TBLPROPERTIES ('hbase.table.name' = 'hannifan_final');

insert overwrite table hannifan_interactions_hive
  select drug_1_id,
  drug_1_name,
  drug_2_id,
  drug_2_name,
  condition_id,
  condition_name,
  A,
  B,
  C,
  D,
  prr,
  prr_err,
  mean_reporting_frequency from twosides;
