#!/bin/sh
rpm -Uvh https://repo.zabbix.com/zabbix/5.0/rhel/7/x86_64/zabbix-release-5.0-1.el7.noarch.rpm
yum -y install zabbix-agent sysstat
mkdir /root/agent_conf
cd /root/agent_conf
wget http://cdn-zabbix-1.cdnvips.net/agent_conf/cpu_status/rh7/cpu0_user_usage.sh
wget http://cdn-zabbix-1.cdnvips.net/agent_conf/cpu_status/rh7/cpu1_user_usage.sh
wget http://cdn-zabbix-1.cdnvips.net/agent_conf/cpu_status/rh7/cpu2_user_usage.sh
wget http://cdn-zabbix-1.cdnvips.net/agent_conf/cpu_status/rh7/cpu3_user_usage.sh
wget http://cdn-zabbix-1.cdnvips.net/agent_conf/cpu_status/rh7/cpu0_sys_usage.sh
wget http://cdn-zabbix-1.cdnvips.net/agent_conf/cpu_status/rh7/cpu1_sys_usage.sh
wget http://cdn-zabbix-1.cdnvips.net/agent_conf/cpu_status/rh7/cpu2_sys_usage.sh
wget http://cdn-zabbix-1.cdnvips.net/agent_conf/cpu_status/rh7/cpu3_sys_usage.sh
wget http://cdn-zabbix-1.cdnvips.net/agent_conf/tcp_status.sh
wget http://cdn-zabbix-1.cdnvips.net/agent_conf/zabbix_agentd.conf
wget http://cdn-zabbix-1.cdnvips.net/agent_conf/status_TCP.conf
chmod 755 *.sh
mkdir -p /usr/lib/zabbix/alertscripts
/bin/cp -rp *.sh /usr/lib/zabbix/alertscripts/
/bin/cp -rp status_TCP.conf /etc/zabbix/zabbix_agentd.d/
mv /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf.bak
/bin/cp -rp zabbix_agentd.conf /etc/zabbix/
/usr/bin/openssl rand -hex 32 > /etc/zabbix/zabbix_agentd.d/agent.psk
mkdir -p /etc/zabbix/scripts
/bin/cp -rp tcp_status.sh /etc/zabbix/scripts/
chown zabbix:zabbix /etc/zabbix/scripts/tcp_status.sh
touch /tmp/tcp_status.txt
chown zabbix:zabbix /tmp/tcp_status.txt
service zabbix-agent restart
systemctl enable zabbix-agent
