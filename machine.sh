sudo su
sed -i -e 's/#PasswordAuthentication yes/PasswordAuthentication yes/i' /etc/ssh/sshd_config
sed -i -e 's/PasswordAuthentication no/#PasswordAuthentication no/i' /etc/ssh/sshd_config
systemctl restart sshd

sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
sudo setenforce 0

sudo timedatectl  set-timezone  Asia/Taipei
sudo yum install ntpdate -y
sudo ntpdate time.stdtime.gov.tw

#ulimit -SHn 65535
sudo cat >>/etc/security/limits.conf<<eof
* soft nproc 65535
* hard nproc 65535
* soft nofile 65535
* hard nofile 65535

root soft nproc 65535
root hard nproc 65535
root soft nofile 65535
root hard nofile 65535
eof

cat >>/etc/sysctl.conf<<eof
net.ipv4.ip_local_port_range = 1024 65535
net.core.netdev_max_backlog = 20000
net.core.somaxconn = 65535
net.core.optmem_max = 81920
net.ipv4.tcp_fin_timeout = 30
fs.file-max = 265535
eof

systemctl stop firewalld
systemctl disable firewalld
systemctl mask firewalld

systemctl stop yum-cron
systemctl disable yum-cron
