#!/usr/bin/env bash

if [ ! -d src ]; then
    echo "You must run this script in the root directory (i.e. ./tools/clang-tidy.all.sh)"
    exit 1
fi

if [ ! -f compile_commands.json ]; then
    echo "You must have a compile_commands.json file in this directory, it can be generated with cmake's -DCMAKE_EXPORT_COMPILE_COMMANDS=ON flag"
    exit 1
fi

echo "$@"

find src/ \( -iname "*.hpp" -o -iname "*.cpp" \) -print -exec clang-tidy {} \;
# find tests/src/ \( -iname "*.hpp" -o -iname "*.cpp" \) -exec clang-format -i {} \;
