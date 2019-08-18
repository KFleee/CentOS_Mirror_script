#! /bin/bash


###Nginx Install####
function install_nginx(){
tmp=$(rpm -qa nginx)
if [ ${tmp}X == X ]; then
releasever=$(rpm -qi centos-release | grep -i "version" | awk -F ":" '{print $2}')
basearch=$(rpm -qi centos-release | grep -i "architecture" | sed 's/[[:space:]][[:space:]]*//g'  |awk -F ":" '{print $2}')
/bin/cat > /etc/yum.repos.d/nginx.repo << EOF
# nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/${basearch}/
gpgcheck=0
enabled=1
EOF
yum install -y nginx
fi
path=$1
/bin/cat > /etc/nginx/nginx.conf << EOF
user  nginx;
worker_processes  1;
error_log  /var/log/nginx/error.log;
pid        /var/run/nginx.pid;
events {
    worker_connections  1024;
}
http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;
    access_log  /var/log/nginx/access.log;
    sendfile        on;
    keepalive_timeout  65;
    server {
    listen       80;
	server_name  0.0.0.0;
    location / {
        root   ${path};
        autoindex on;
        autoindex_exact_size off;
        autoindex_localtime on;
    }
}
}
EOF
process=$(lsof -i:80 | awk '$2!="PID"{print $2}')
for i in ${process}
do
kill -9 ${i}
done
nginx -c /etc/nginx/nginx.conf
systemctl stop firewalld.service
}