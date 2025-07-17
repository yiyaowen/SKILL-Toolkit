#!/bin/bash
# 递归删除指定目录及子目录下的所有形如*.cdslck*的文件
path1=$(pwd)
if [ -z "$1" ]
then
    echo "Usage: [./clear_cdslck.sh path/to/project]"
    exit 1
fi
cd "$1"
if [ $? -eq 0 ]
then
    path2=$(pwd)
    echo "Clearing (cdslck) @ ${path2}"
    find . -type f -name "*.cdslck*" -exec rm -f {} +
else
    echo "No cdslck file is cleared due to the above error(s)."
fi
cd ${path1}
