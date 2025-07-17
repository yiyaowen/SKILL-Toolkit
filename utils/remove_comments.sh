#!/bin/sh
# 递归删除指定目录及子目录下的所有*.v文件中的//注释
path1=$(pwd)
if [ -z "$1" ]
then
    echo "Usage: [./rmcm.sh path/to/project]"
    exit 1
fi
cd "$1"
if [ $? -eq 0 ]
then
    path2=$(pwd)
    echo "Removing Comments @ ${path2}"
    find ${path2} \( -name "*.v" \) | xargs sed -i 's/[[:space:]]*\/\/.*//g'
else
    echo "No comment is removed due to the above error(s)."
fi
cd ${path1}
