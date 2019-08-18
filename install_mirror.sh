#!/bin/bash

function install_mirror(){
start_time=$(date "+%Y-%m-%d %H:%M:%S")
echo ${start_time}':start rsync...'
source /etc/profile
path=$1
tmp=$(rpm -qa createrepo)
if [ ${tmp}X == X ]; then
yum install createrepo -y
fi
####CentOS 7###

/usr/bin/rsync -avzL --exclude=atomic --exclude=centosplus --exclude=cloud --exclude=configmanagement --exclude=dotnet --exclude=cr --exclude=fasttrack --exclude=isos --exclude=opstool --exclude=paas --exclude=rt --exclude=sclo --exclude=storage --exclude=virt --exclude=RELEASE-NOTES* --exclude=i386 --exclude=*i386.rpm --exclude=repodata rsync://rsync.mirrors.ustc.edu.cn/repo/centos/7/ ${path}/CentOS/7

/usr/bin/rsync -avzL  rsync://rsync.mirrors.ustc.edu.cn/centos/7/sclo/x86_64/rh/devtoolset-7/ ${path}/CentOS/7/sclo/x86_64/rh/devtoolset-7

for i in ${path}/CentOS/7/extras/x86_64 ${path}/CentOS/7/os/x86_64 ${path}/CentOS/7/updates/x86_64 ${path}/CentOS/7/sclo/x86_64 ; do /bin/rm $i/repodata -rf && /usr/bin/createrepo -s sha --workers 8 $i ;done

####CentOS 6###

/usr/bin/rsync -avzL --exclude=atomic --exclude=centosplus --exclude=cloud --exclude=configmanagement --exclude=dotnet --exclude=cr --exclude=fasttrack --exclude=isos --exclude=opstool --exclude=paas --exclude=rt --exclude=sclo --exclude=storage --exclude=virt --exclude=RELEASE-NOTES* --exclude=i386 --exclude=*i386.rpm --exclude=repodata rsync://rsync.mirrors.ustc.edu.cn/repo/centos/6/ ${path}/CentOS/6

for i in ${path}/CentOS/6/extras/x86_64 ${path}/CentOS/6/os/x86_64 ${path}/CentOS/6/updates/x86_64 ; do /bin/rm $i/repodata -rf && /usr/bin/createrepo -s sha --workers 8 $i ;done
end_time=$(date "+%Y-%m-%d %H:%M:%S")
duration=`echo eval $(($(date +%s -d "${end_time}") - $(date +%s -d "${start_time}"))) | awk '{t=split("60 s 60 m 24 h 999 d",a);for(n=1;n<t;n+=2){if($1==0)break;s=$1%a[n]a[n+1]s;$1=int($1/a[n])}print s}'`
echo  ${end_time}':end rsync...  duration:'${duration}
}   
