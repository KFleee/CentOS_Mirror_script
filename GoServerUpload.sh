#! /bin/bash

echo "Strat copy GoWebServer to $GOPATH/src......."
cp -R /Users/lijiahui/works/Go_Web_Server/src/Server $GOPATH/src
echo "finish copy........."

echo "--------------------------"

echo "Start install Server........."
cd $GOPATH
GOOS=linux GOARCH=amd64 go install Server
echo "finish install......."

echo "--------------------------"

echo "Start upload Server........"
cd $GOPATH/bin/linux_amd64
scp -r Server root@139.199.59.7:/root/Golang/bin/

echo "-------------------------"

echo "delete source file........"
rm -rf $GOPATH/bin/linux_amd64
rm -rf $GOPATH/src/Server
echo "Finish upload.........."
