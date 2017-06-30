cmake_minimum_required(VERSION 2.8)

set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_VERBOSE_MAKEFILE ON)

project(egcas_maxima)

include(ExternalProject)


ExternalProject_Add(egcas_maxima
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/maxima
    CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/maxima/configure --prefix=${CMAKE_CURRENT_BINARY_DIR}/inst
    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/inst
    BUILD_COMMAND make
    #BUILD_IN_SOURCE 1
    )

