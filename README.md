

## To run locally:

1. Copy to Docker container
```
sudo docker cp big-data-architecture mpcs53014_container:/home/hadoop/
```
2. Login to container as root. Add permissions to app directory for hadoop user. Ensure xz-utils is installed.
```
sudo chown -R hadoop:hadoop /home/hadoop/big-data-architecture/
sudo apt-get install xz-utils
```
3. Change to hadoop user and start services.
```
sudo su hadoop
start-all.sh
start-hbase.sh
```
4. Change to app directory and run layers.
```
cd big-data-architecture/batch-layer
sh run.sh

cd ../serving-layer
sh run.sh
```




### Grant rw permissions to hadoop project directory (run as root)

sudo apt-get install xz-utils


,drug_1_rxnorn_id,drug_1_concept_name,drug_2_rxnorm_id,drug_2_concept_name,condition_meddra_id,condition_concept_name,A,B,C,D,PRR,PRR_error,mean_reporting_frequency
0,10355,Temazepam,136411,sildenafil,10003239,Arthralgia,7,149,24,1536,2.91667,0.421275,0.0448718




42920392 rows