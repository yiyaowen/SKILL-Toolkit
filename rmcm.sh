#!/bin/sh

path1=$(pwd)

if [ x$1 != x ]
then
    cd "$1"
    if [ $? -eq 0 ]
    then
        path2=$(pwd)
        echo "Removing Comment @ ${path2}"
        find ${path2} \( -name "*.v" \) | xargs sed -i 's/[[:space:]]*\/\/.*//g'
    else
        echo "No comment is removed due to the above error(s)."
    fi
else
    echo "Usage: [./rmcm.sh path/to/project]"
fi

cd ${path1}
