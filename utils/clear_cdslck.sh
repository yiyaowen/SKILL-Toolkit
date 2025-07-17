#!/bin/bash
# 递归删除当前目录及子目录下的所有形如*.cdslck*的文件
find . -type f -name "*.cdslck*" -exec rm -f {} +
