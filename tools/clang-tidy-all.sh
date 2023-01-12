#!/usr/bin/env bash

MAX_JOBS="16"

if [ ! -d src ]; then
    echo "You must run this script in the root directory (i.e. ./tools/clang-tidy.all.sh)"
    exit 1
fi

if [ ! -f compile_commands.json ]; then
    echo "You must have a compile_commands.json file in this directory, it can be generated with cmake's -DCMAKE_EXPORT_COMPILE_COMMANDS=ON flag"
    exit 1
fi

mkdir -p reports

time find src/ \( -iname "*.hpp" -o -iname "*.cpp" \) -print0 | xargs --max-args 1 --null --max-procs="$MAX_JOBS" clang-tidy "$@" | tee reports/clang-tidy-src.txt
time find tests/src/ \( -iname "*.hpp" -o -iname "*.cpp" \) -print0 | xargs --max-args 1 --null --max-procs="$MAX_JOBS" clang-tidy "$@" | tee reports/clang-tidy-tests-src.txt
