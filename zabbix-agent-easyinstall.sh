#!/bin/bash

###### VARIABLES ######
linuxver=$(lsb_release -da |grep Codename |awk '{print $2}')
host=$(hostname)
# Change the agentvar to match the Zabbix installation version
agentvar="3.4.3"
# Change the repo to match major release of Zabbix
repo="3.4"
# Change the IP of zabbixserver to a proxy or a server IP address
zabbixserver="IP"

###### DOWNLOAD ZABBIX AGENT ######

## Install dependencies ##

apt-get install libcurl3
###
cd /tmp/

wget http://repo.zabbix.com/zabbix/$repo/ubuntu/pool/main/z/zabbix/zabbix-agent_$agentvar-1+$linuxver'_amd64.deb'

dpkg -i zabbix-agent_$agentvar-1+$linuxver'_amd64.deb'

rm zabbix-agent_$agentvar-1+$linuxver'_amd64.deb'

rm /etc/zabbix/zabbix_agentd.conf

touch /etc/zabbix/zabbix_agentd.conf

###### AGENT CONFIGURATION FILE ######

echo ' ############ GENERAL PARAMETERS #################

Hostname='$host'
LogFile=/var/log/zabbix-agent/zabbix_agentd.log
PidFile=/var/run/zabbix/zabbix_agentd.pid
LogFileSize=10
DebugLevel=3
EnableRemoteCommands=1
LogRemoteCommands=1

Server='$zabbixserver'
StartAgents=4
ServerActive='$zabbixserver'

############ ADVANCED PARAMETERS #################

AllowRoot=0
Include=/etc/zabbix/zabbix.d' > /etc/zabbix/zabbix_agentd.conf

## MKDIR Block
mkdir /etc/zabbix/external.d/
mkdir /etc/zabbix/zabbix.d/
mkdir /var/run/zabbix/
mkdir /var/log/zabbix/
mkdir /var/log/zabbix-agent/

touch /var/log/zabbix-agent/zabbix_agentd.log

## CHOWN Block
chown zabbix:zabbix /var/run/zabbix/
chown zabbix:zabbix /var/run/zabbix/
chmod 755 /var/log/zabbix/
chown zabbix:zabbix /var/log/zabbix/
chmod 664 /var/log/zabbix/
chown zabbix:zabbix /etc/zabbix/
chown zabbix:zabbix /var/log/zabbix-agent/zabbix_agentd.log

## Restart the service
service zabbix-agent restart

echo "Zabbix Agent Installed, Configured and Restarted - End of the script..."
