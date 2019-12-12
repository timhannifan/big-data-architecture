-- This file will create an ORC table from the Hive table twoside_csv 
drop table if exists twosides;
create table twosides(
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
  stored as orc;

-- Copy the CSV table to the ORC table
insert overwrite table twosides select * from twosides_csv
where drug_1_id is not null and drug_2_id is not null
and A is not null and B is not null and C is not null and D is not null;

-- Run a test query to make sure the data was successfully stored

select * from twosides limit 5;