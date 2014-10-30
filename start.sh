#!/bin/bash
mkdir -p /var/zookeeper
if [ "X$ZOOKEEPER_ID" = "X" ]; then
    echo "ZOOKEEPER_ID is required" 
fi 
echo $ZOOKEEPER_ID > /var/zookeeper/myid


echo "tickTime=2000" > /opt/zookeeper/conf/zoo.cfg 
echo "dataDir=/var/zookeeper" >> /opt/zookeeper/conf/zoo.cfg 
echo "clientPort=2181" >> /opt/zookeeper/conf/zoo.cfg
echo "initLimit=5" >> /opt/zookeeper/conf/zoo.cfg
echo "syncLimit=2" >> /opt/zookeeper/conf/zoo.cfg 
for i in `echo "$ZOOKEEPER_MAPPING" | sed "s/,/ /g"`
do
  n=`echo $i | cut -d":" -f 1`
  h=`echo $i | cut -d":" -f 2`
  echo "server.${n}=${h}:2888:3888" >> /opt/zookeeper/conf/zoo.cfg
done
cat /opt/zookeeper/conf/zoo.cfg


exec /opt/zookeeper/bin/zkServer.sh $@
