#!/bin/bash
#---------------------------------------------------------------------------
#
# Copyleft by yiyaowen (L) July, 2025
# Also see: https://github.com/yiyaowen/SKILL-Toolkit
#
#---------------------------------------------------------------------------
#
# 递归删除指定目录及子目录下的所有形如 *.cdslck* 的文件
#
#---------------------------------------------------------------------------
if [ -z "$1" ]
then
    echo -e "\e[1;34mUsage: ./clear_cdslck.sh <directory>\e[0m"
    exit 1
fi
path1=$(pwd)
cd "$1"
if [ $? -eq 0 ]
then
    path2=$(pwd)
    echo -e "\e[1;32mOK\e[0m: Clearing cdslck @ ${path2}"
    find ${path2} -type f -name "*.cdslck*" -exec rm -f {} +
else
    echo -e "\e[1;31mFailed\e[0m: No cdslck is cleared due to the above error(s)."
fi
cd ${path1}
