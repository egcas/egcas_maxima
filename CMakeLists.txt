cmake_minimum_required(VERSION 2.8)

set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_VERBOSE_MAKEFILE ON)

project(egcas_maxima)

include(ExternalProject)

if (NOT MAXIMA_INST_PATH)
        set(MAXIMA_INST_PATH maxima_installation)
endif()


ExternalProject_Add(egcas_maxima
    PATCH_COMMAND touch ${CMAKE_CURRENT_SOURCE_DIR}/maxima/configure.ac ${CMAKE_CURRENT_SOURCE_DIR}/maxima/aclocal.m4 ${CMAKE_CURRENT_SOURCE_DIR}/maxima/configure ${CMAKE_CURRENT_SOURCE_DIR}/maxima/Makefile.am ${CMAKE_CURRENT_SOURCE_DIR}/maxima/Makefile.in
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/maxima
    CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/maxima/configure
                      --prefix=${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/ 
                      --enable-sbcl
    PREFIX ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}
    BUILD_COMMAND make
    BUILD_IN_SOURCE 1
)


if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
        set(MAXIMA_INSTALL_DIR /usr/bin/egcas-maxima)
        install(PROGRAMS ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/bin/maxima DESTINATION ${MAXIMA_INSTALL_DIR}/bin)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/lib/ DESTINATION ${MAXIMA_INSTALL_DIR}/lib/)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/libexec/ DESTINATION ${MAXIMA_INSTALL_DIR}/libexec/)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/share/ DESTINATION ${MAXIMA_INSTALL_DIR}/share/)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/src/ DESTINATION ${MAXIMA_INSTALL_DIR}/src/)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/tmp/ DESTINATION ${MAXIMA_INSTALL_DIR}/tmp/)
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
        set(MAXIMA_INSTALL_DIR egcas-maxima)
        install(PROGRAMS ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/bin/maxima DESTINATION ${MAXIMA_INSTALL_DIR}/bin)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/lib/ DESTINATION ${MAXIMA_INSTALL_DIR}/lib/)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/libexec/ DESTINATION ${MAXIMA_INSTALL_DIR}/libexec/)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/share/ DESTINATION ${MAXIMA_INSTALL_DIR}/share/)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/src/ DESTINATION ${MAXIMA_INSTALL_DIR}/src/)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/tmp/ DESTINATION ${MAXIMA_INSTALL_DIR}/tmp/)
endif()

