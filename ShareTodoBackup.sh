#! /bin/bash

echo "start to backup"
path=/Users/lijiahui/works/
[ -d ${path} ] && cd ${path}
filePath="ShareTodo_Backup/"
[ -d ${filePath} ] || mkdir ${filePath} 
cd ${filePath}
fileName="ShareTodo_"$(date +%Y-%m-%d)"_backup.tar.gz"
backup=${path}${filePath}${fileName}
echo ${fileName}
echo ${backup}
cd /Users/lijiahui/workspace-spring-tool-suite-4-4.1.2.RELEASE/
tar -zcvf ${backup} ShareTodo/
echo "finish"  
