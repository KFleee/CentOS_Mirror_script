#! /bin/bash

cd /Users/lijiahui/workspace-spring-tool-suite-4-4.1.2.RELEASE/ShareTodo
echo 'start build project'
gradle build
#echo 'start to copy war file to Desktop'
#cp build/libs/ShareTodo* /Users/lijiahui/Desktop
#echo 'finish copy'
echo 'start push to service....'
scp build/libs/ShareTo* root@139.199.59.7:/root/ShareTodo/
echo 'finish push'
