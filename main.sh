#! /bin/bash
. /opt/ws_script/install_nginx.sh
. /opt/ws_script/install_mirror.sh
source /etc/profile
echo "nameserver 119.29.29.29" > /etc/resolv.conf
echo "nameserver 223.5.5.5" >> /etc/resolv.conf
echo "nameserver 114.114.114.114" >> /etc/resolv.conf
tmp=$(rpm -qa lsof)
if [ ${tmp}X == X ];then
yum install -y lsof
fi
path=/yum
ipAddr=www.test2.com
port=80
echo "start install nginx......"
install_nginx ${path}
echo "start create repo file....."
[ -d ${path}/CentOS/7 ] || mkdir -p ${path}/CentOS/7
[ -d ${path}/CentOS/7/sclo/x86_64/rh/devtoolset-7 ] || mkdir -p ${path}/CentOS/7/sclo/x86_64/rh/devtoolset-7
[ -d ${path}/CentOS/7/extras/x86_64 ] || mkdir -p ${path}/CentOS/7/extras/x86_64
[ -d ${path}/CentOS/7/os/x86_64 ] || mkdir -p ${path}/CentOS/7/os/x86_64
[ -d ${path}/CentOS/7/updates/x86_64 ] || mkdir -p ${path}/CentOS/7/updates/x86_64
[ -d ${path}/CentOS/7/sclo/x86_64 ] || mkdir -p ${path}/CentOS/7/sclo/x86_64
[ -d ${path}/CentOS/6 ] || mkdir -p ${path}/CentOS/6
[ -d ${path}/CentOS/6/extras/x86_64 ] || mkdir -p ${path}/CentOS/6/extras/x86_64
[ -d ${path}/CentOS/6/os/x86_64 ] || mkdir -p ${path}/CentOS/6/os/x86_64
[ -d ${path}/CentOS/6/updates/x86_64 ] || mkdir -p ${path}/CentOS/6/updates/x86_64
/bin/cat > ${path}/CentOS-6.repo << EOF
[base]
name=CentOS-6 - Base
baseurl=http://${ipAddr}:${port}/CentOS/6/os/x86_64
gpgcheck=0
[updates]
name=CentOS-6 - Updates
baseurl=http://${ipAddr}:${port}/CentOS/6/updates/x86_64
gpgcheck=0
[extras]
name=CentOS-6 - Extras
baseurl=http://${ipAddr}:${port}/CentOS/6/extras/x86_64
gpgcheck=0
EOF
/bin/cat > ${path}/CentOS-7.repo << EOF
[base]
name=CentOS-7 - Base
baseurl=http://${ipAddr}:${port}/CentOS/7/os/x86_64
gpgcheck=0
[updates]
name=CentOS-7 - Updates
baseurl=http://${ipAddr}:${port}/CentOS/7/updates/x86_64
gpgcheck=0
[extras]
name=CentOS-7 - Extras
baseurl=http://${ipAddr}:${port}/CentOS/7/extras/x86_64
gpgcheck=0
EOF
echo "start rsync mirror......"
tmp=$(rpm -qa rsync)
if [ ${tmp}X == X ];then
yum install -y rsync
fi
#/usr/bin/rsync --daemon --config=/etc/rsyncd.conf
install_mirror ${path}
echo "start cron...."
dir=$(pwd)
crontab -l > crontab_test
echo " * 0 * * * bash ${dir}/cron.sh ${path} 2>&1 >> ${dir}/log" >> crontab_test
crontab crontab_test
echo "finish"
