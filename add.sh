#!/bin/bash
#yum update
user=qqadmin
authkey=" [PUBLIC key放這]  "
#if [ ! $(cat /etc/passwd|grep ^${user}) ]; then
useradd $user
mkdir -p /home/${user}/.ssh
touch /home/${user}/.ssh/authorized_keys
echo ${authkey} >> /home/${user}/.ssh/authorized_keys
cp /root/.bashrc /home/${user}
cp /root/.profile /home/${user}
chown -R $user:$user /home/$user
echo -e "1qaz@WSX3edc$RFV\n1qaz@WSX3edc$RFV" | passwd $user
#sed -i "s#$(cat /etc/passwd|grep ^${user})#$(cat /etc/passwd|grep ^${user})\/bin\/bash#g" /etc/passwd
usermod -aG sudo ${user}
#fi

# change /etc/sudoers
chmod 775 /etc/sudoers
SUDO_STRAF="%sudo ALL=(ALL:ALL) NOPASSWD:ALL"
SUDO_STRBE=$(cat /etc/sudoers |grep "^%sudo")

if [ $? -ne 0 ]; then
echo $SUDO_STRAF >> /etc/sudoers
else
sed -i "s#$SUDO_STRBE#$SUDO_STRAF#g" /etc/sudoers
fi
chmod 440 /etc/sudoers

# cat /etc/*release*|grep ID
echo "qqadmin       ALL=(ALL)       NOPASSWD:ALL">>/etc/sudoers
sudo -i
