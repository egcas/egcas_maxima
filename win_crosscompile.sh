#!/bin/bash -e

EGCAS_MAXIMA_ROOT_DIR=$(dirname "${0}")
CMAKE_EXECUTABLE=""

if [ -z "${1}" ]; then
        echo "no cmake executable given... aborting..."
        exit 1 
else
        CMAKE_EXECUTABLE="${1}"
fi

cd maxima
patch -p1 < ../egcas-maxima.patch 
cd crosscompile-windows/build/
"${CMAKE_EXECUTABLE}" ..
make maxima


