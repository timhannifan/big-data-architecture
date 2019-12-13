-- This file will map the csv data in Hive and create an intermediate table

drop table if exists twosides_csv;
create external table twosides_csv(
  row_n string,
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
  row format serde 'org.apache.hadoop.hive.serde2.OpenCSVSerde'

WITH SERDEPROPERTIES (
   "separatorChar" = "\,",
   "quoteChar"     = "\""
)
STORED AS TEXTFILE
  location '/inputs/hannifan_project';

-- Run a test query to make sure the data was successfully stored
select drug_1_name,drug_2_name,condition_name,prr from twosides_csv limit 5;


