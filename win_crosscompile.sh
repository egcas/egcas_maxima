#!/bin/bash -e


function usage()
{
        echo "${0} -C MXI_CMAKE_EXECUTABLE -i INSTALLATION_DIR [-h]"
        echo "------------------------------------------------------------------"
        echo "-C MXI_CMAKE_EXECUTABLE: the cmake executable to use to build maxima"
        echo "-i INSTALLATION_DIR: the installation directory where to install the maxima files to, so that cpack can find it."
        echo "-h : show this help"
}


EGCAS_MAXIMA_ROOT_DIR=$(dirname "${0}")
MXI_CMAKE_EXECUTABLE=""
MXI_MAXIMA_INSTALLATION_DIR=""


if [ -z "${1}" ]; then
        echo ""
        echo "error: incorrect arguments..."
        echo ""
        usage
        exit 1 
else
        MXI_CMAKE_EXECUTABLE="${1}"
fi

OPTIND=1         
while getopts "h?C:i:" OPT; do
    case "$OPT" in
    h|\?)
        usage
        exit 0
        ;;
    C)  MXI_CMAKE_EXECUTABLE="${OPTARG}"
        ;;
    i)  MXI_MAXIMA_INSTALLATION_DIR="${OPTARG}"
        ;;
    esac
done

if [[ "${MXI_CMAKE_EXECUTABLE}" == "" || "${MXI_MAXIMA_INSTALLATION_DIR}" == ""  ]]; then
        echo ""
        echo "insufficient arguments"
        echo ""
        usage
        exit 2
fi

# build maxima
cd maxima
patch -p1 < ../egcas-maxima.patch 
cd crosscompile-windows/build/
MXI_MAXIMA_BUILD_DIR="${PWD}"
"${MXI_CMAKE_EXECUTABLE}" ..
make maxima
#delete old installation dir if existent
if [ -d "${MXI_MAXIMA_INSTALLATION_DIR}" ]; then
        cd "${MXI_MAXIMA_INSTALLATION_DIR}"
        cd ..
        rm -r $(basename "${MXI_MAXIMA_INSTALLATION_DIR}")
fi
mkdir -p "${MXI_MAXIMA_INSTALLATION_DIR}"
cd "${MXI_MAXIMA_BUILD_DIR}"
cd "C:/maxima_installation/"
cp -r * "${MXI_MAXIMA_INSTALLATION_DIR}"


