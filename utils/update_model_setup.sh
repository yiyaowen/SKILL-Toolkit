#!/bin/bash
#---------------------------------------------------------------------------
#
# Copyleft by yiyaowen (L) July, 2025
# Also see: https://github.com/yiyaowen/SKILL-Toolkit
#
#---------------------------------------------------------------------------
#
# 递归更新指定目录及子目录下的所有 modelSetup.state 文件
#
#---------------------------------------------------------------------------
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ];
then
    echo -e "\e[1;34mUsage: ./update_model_setup.sh <directory> <old_dir> <new_dir>\e[0m"
    exit 1
fi
path1=$(pwd)
cd "$1"
if [ $? -eq 0 ]
then
    path2=$(pwd)
    echo -e "\e[1;32mOK\e[0m: Updating modelSetup.state @ ${path2}"
    find ${path2} -type f -name "modelSetup.state" | while read -r file; do
        sed -i "s/${2}/${3}/g" "$file"
    done
else
    echo -e "\e[1;31mFailed\e[0m: No modelSetup.state is updated due to the above error(s)."
fi
cd ${path1}
