

## About
This repository contains code to consume Twosides, a comprehensive database of adverse side effects from pharmacological cobinations. The dataset is 4.3GB and contains around 72 million cobminations of drugs, side effects, and data-mined/FDA reported propensity scores for each tuplet.

The intention is twofold: to demonstrate the layers of the lambda architecture, and to provide a scalable platform to do [research on this topic using matrix factorization and machine learning](https://github.com/timhannifan/drug-reaction-matrix-factorization).



## To run locally:

1. Clone this repo. The second line runs a script to start Docker, copy the source code to the container, and log in aas the root user.
```
git clone https://github.com/timhannifan/big-data-architecture application
cd application && run_docker.sh
```
2. Install prerequisites. Add permissions to application directory for hadoop user.
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
4. Run the batch layer.
```
cd ~/application/batch-layer && sh run.sh
```

5. Create a Hbase table for the serving layer, then create serving views.

```
$ hbase shell
create 'hannifan_twosides_hbase', 'interactions'
create 'hannifan_twosides_conditions', 'c'
exit

$ cd ~/application/serving-layer && sh run.sh
```

6. Start the web application

```
$ cd ~/application/ui && node app.js
```

The batch layer scripts:
- Download [Twosides data](http://tatonettilab.org/resources/nsides/) and extract the data
- Ingest the raw csv data into HDFS
- Create Hive table containg the raw csv data
- Copy the raw Hive table into a new table in ORC formaat

The serving layer scripts:
- Create an external HBase table from the ORC table

The ui script:
- Starts the Node.js web application on localhost:30000.
- Generates tables with get requests to Hbase.
- See `localhost:30000/conditions.html` for example.

*The speed layer scripts:*
- *Under construction*


## To run from scratch on the cloud:

1. Generate the batch layer: ingest csv to HDFS and use Hive to create batch views
```
git clone https://github.com/timhannifan/big-data-architecture ~/application
cd ~/application/src/batch-layer && sh run.sh
```

2. Generate the serving layer: use Hive to create HBase tables for API consumption

First create new column family in hbase for our complete data, then a separate view grouped by condition.
```
$ hbase shell
create 'hannifan_twosides_hbase', 'interactions'
create 'hannifan_twosides_conditions', 'c'
exit
```

Then run the hive scripts in the serving layer directory to create HBase views:
```
cd ~/application/src/serving-layer && sh run.sh
```


3. Start Speed layer
- Create a kafka topic `hannifan_latest_interactions` for incoming data
```
cd /usr/hdp/current/kafka-broker/bin

# Create a kafka topic named latest_interactions
sh kafka-topics.sh --create --zookeeper mpcs53014c10-m-6-20191016152730.us-central1-a.c.mpcs53014-2019.internal:2181 --replication-factor 1 --partitions 1 --topic hannifan_latest_interactions

# Check that it exits
sh kafka-topics.sh --list --zookeeper mpcs53014c10-m-6-20191016152730.us-central1-a.c.mpcs53014-2019.internal:2181 | grep 'hannifan'

```

- Create a hbase table for the real-time (combined serving and speed) data
```
hbase shell
hbase> create 'hannifan_realtime_interactions', 'interaction'
```

4. Start Web application on webserver
```
gcloud compute ssh hannifan@webserver

## app is transfered from local machine. A copy exists on the webserver.
cd ~/ui && node app.js
```

The application can be viewed at (this link on the cluster)[http://34.66.189.234:3584/conditions.html].


5. To simulate the speed layer, go to the form on the website and enter information. It will be send via the kafka topic hannifan_latest_interactions, then consumed via a spark job and added to the hbase table hannifan_realtime_interactions.



(Submission form)[http://34.66.189.234:3584/report.html] 

