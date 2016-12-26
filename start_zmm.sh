#!/usr/bin/env bash

echo
echo "######################"
echo "# Starting Zookeeper #"
echo "######################"
echo

/root/zookeeper-3.4.9/bin/zkServer.sh start

echo
echo "#########################"
echo "# Starting Mesos Master #"
echo "#########################"
echo

/usr/sbin/mesos-master --zk=zk://localhost:2181/mesos --quorum=1 --work_dir=/usr/lib/mesos/master &

echo
echo "########################"
echo "# Starting Mesos Agent #"
echo "########################"
echo

/usr/sbin/mesos-slave --no-systemd_enable_support --master=zk://localhost:2181/mesos --work_dir=/usr/lib/mesos/agent &

echo
echo "#####################"
echo "# Starting Marathon #"
echo "#####################"
echo

export MESOS_NATIVE_JAVA_LIBRARY=/usr/lib/libmesos.so
/root/marathon-1.3.5/bin/start --master zk://localhost:2181/mesos --zk zk://localhost:2181/marathon &
