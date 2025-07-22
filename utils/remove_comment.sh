#!/bin/bash
#---------------------------------------------------------------------------
#
# Copyleft by yiyaowen (L) July, 2025
# Also see: https://github.com/yiyaowen/SKILL-Toolkit
#
#---------------------------------------------------------------------------
#
# 递归删除指定目录及子目录下的所有匹配的源文件中的 // 注释
#
#---------------------------------------------------------------------------
if [ -z "$1" ]
then
    echo -e "\e[1;34mUsage: ./remove_comment.sh <directory> *.[v|va|vams]\e[0m"
    exit 1
fi
name="*.v"
if [ -n "$2" ]; then
    name="$2"
fi
path1=$(pwd)
cd "$1"
if [ $? -eq 0 ]
then
    path2=$(pwd)
    echo -e "\e[1;32mOK\e[0m: Removing Comment @ ${path2}"
    find ${path2} -type f -name ${name} | xargs sed -i 's/[[:space:]]*\/\/.*//g'
else
    echo -e "\e[1;31mFailed\e[0m: No comment is removed due to the above error(s)."
fi
cd ${path1}
