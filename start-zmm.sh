#!/usr/bin/env bash

##########################
# Run Zookeeper          #
##########################

/root/zookeeper-3.4.9/bin/zkServer.sh start

##########################
# Run Mesos Master       #
##########################

/usr/sbin/mesos-master --zk=zk://localhost:2181/mesos --quorum=1 --work_dir=/usr/lib/mesos/master

##########################
# Run Mesos Agent        #
##########################

/usr/sbin/mesos-slave --no-systemd_enable_support  --master=zk://localhost:2181/mesos --work_dir=/usr/lib/mesos/agent

##########################
# Run Marathon           #
##########################

export MESOS_NATIVE_JAVA_LIBRARY=/usr/lib/libmesos.so
/root/marathon-1.3.5/bin/start --master zk://localhost:2181/mesos --zk zk://localhost:2181/marathon
