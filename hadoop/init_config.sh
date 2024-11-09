#!/bin/bash
# export HADOOP_HOME = "XXX"

usage() {
    echo "Usage:"
    exit -1
}

dfs="hdfs://localhost:9000"
tmp_dir="/E/HADOOP/hdata"
replication="1"
HADOOP_MAPRED_HOME="/E/HADOOP"

while getopts 'd:t:r:h' OPT; do
    case $OPT in
        d) dfs="$OPTARG";;
        t) tmp_dir="$OPTARG";;
        r) replication="$OPTARG";;
        h) upload="$OPTARG";;
    esac
done

config_core_site() {
    config="""
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>${dfs}</value>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>${tmp_dir}</value>
    </property>
</configuration>
    """
    echo "$config" > $HADOOP_HOME/etc/hadoop/core-site.xml
}

config_hdfs_site() {
    config="""
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>${replication}</value>
    </property>
</configuration>
    """
    echo "$config" > $HADOOP_HOME/etc/hadoop/hdfs-site.xml
}

config_mapred_site () {
    config="""
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
    <property>
        <name>yarn.app.mapreduce.am.env</name>
        <value>HADOOP_MAPRED_HOME=${HADOOP_MAPRED_HOME}</value>
    </property>
    <property>
        <name>mapreduce.map.env</name>
        <value>HADOOP_MAPRED_HOME=${HADOOP_MAPRED_HOME}</value>
    </property>
    <property>
        <name>mapreduce.reduce.env</name>
        <value>HADOOP_MAPRED_HOME=${HADOOP_MAPRED_HOME}</value>
    </property>
</configuration>
    """
    echo "$config" > $HADOOP_HOME/etc/hadoop/mapred-site.xml 
}

config_yarn_site() {
    config="""
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
        <value>org.apache.hadoop.mapred.ShuffleHandler</value>
    </property>  
</configuration>
    """
    echo "$config" > $HADOOP_HOME/etc/hadoop/yarn-site.xml
}

config_core_site
config_hdfs_site
config_mapred_site
config_yarn_site