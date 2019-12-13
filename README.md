

## About
This repository contains code to consume Twosides, a comprehensive database of adverse side effects from pharmacological cobinations. The dataset is 4.3GB and contains around 72 million cobminations of drugs, side effects, and data-mined/FDA reported propensity scores for each tuplet.

The intention is twofold: to demonstrate the layers of the lambda architecture, and to provide a scalable platform to do [research on this topic using matrix factorization and machine learning](https://github.com/timhannifan/drug-reaction-matrix-factorization).

## To run from scratch on the cloud:

1. Generate the batch layer: ingest csv to HDFS and use Hive to create batch views
```
git clone https://github.com/timhannifan/big-data-architecture
cd /big-data-architecture/src/batch-layer
sh run.sh
```

2. Generate the serving layer: use Hive to create HBase tables for API consumption

Create new column family in hbase for our daata
```
hbase shell
> create 'hannifan_final', 'interactions'
```

Then run the hive scripts to create HBase tables
```
cd ../serving-layer
sh run.sh
```

3. Start Web application
*Under construction*

4. Start Speed layer
*Under construction*
