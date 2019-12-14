# /bin/bash
sudo docker start mpcs53014_container
sudo docker cp src mpcs53014_container:/home/hadoop/application
sudo docker exec -i -t mpcs53014_container /bin/bash