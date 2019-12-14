

## About
This repository contains code to consume Twosides, a comprehensive database of adverse side effects from pharmacological cobinations. The dataset is 4.3GB and contains around 72 million cobminations of drugs, side effects, and data-mined/FDA reported propensity scores for each tuplet.

The intention is twofold: to demonstrate the layers of the lambda architecture, and to provide a scalable platform to do [research on this topic using matrix factorization and machine learning](https://github.com/timhannifan/drug-reaction-matrix-factorization).





## To run locally:

1. Clone and copy to Docker container.
```
git clone https://github.com/timhannifan/big-data-architecture 
cd big-data-architecture && run_docker.sh
```
2. Add permissions to app directory for hadoop user. Ensure xz-utils is installed.
```
sudo apt-get install xz-utils
sudo chown -R hadoop:hadoop /home/hadoop/application/
```
3. Change to hadoop user and start services.
```
sudo su hadoop
start-all.sh
start-hbase.sh
```
4. Run the layers.
```
cd ~/application/batch-layer && sh run.sh

cd ~/application/serving-layer && sh run.sh

# cd ~/application/ui && sh run.sh

# cd ~/application/speed-layer && sh run.sh
```

The batch layer scripts:
- Download [Twosides data](http://tatonettilab.org/resources/nsides/) and extract the data
- Ingest the raw csv data into HDFS
- Create Hive table containg the raw csv data
- Copy the raw Hive table into a new table in ORC formaat

The serving layer scripts:
- Create an external HBase table from the ORC table

*The ui scripts (coming soon)*:
- Starts the Node.js web application on localhost:30000/side-effects.html
- Make calls to Hbase tables to GET and PUT data


## To run from scratch on the cloud:

1. Generate the batch layer: ingest csv to HDFS and use Hive to create batch views
```



git clone https://github.com/timhannifan/big-data-architecture
cd /big-data-architecture/src/batch-layer]
sh run.sh
```

2. Generate the serving layer: use Hive to create HBase tables for API consumption

Create new column family in hbase for our daata
```
hbase shell
> create 'hannifan_final', 'interactions'
create 'hannifan_final_grouped', 'interactions'
```

Then run the hive scripts in the serving layer directory to create HBase views:
```
cd ../serving-layer
sh run.sh
```

3. Start Web application
*Under construction*

4. Start Speed layer
*Under construction*


