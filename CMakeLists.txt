cmake_minimum_required(VERSION 2.8)

set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_VERBOSE_MAKEFILE ON)

project(egcas_maxima)

include(ExternalProject)


ExternalProject_Add(egcas_maxima
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/maxima
    CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/maxima/configure --datarootdir=${CMAKE_BINARY_DIR}/maxima_installation/usr/share/egcas/ --prefix=${CMAKE_BINARY_DIR}/maxima_installation/ --program-prefix=egcas- --libexecdir=${CMAKE_BINARY_DIR}/maxima_installation/usr/bin/egcas/ --libdir=${CMAKE_BINARY_DIR}/maxima_installation/usr/lib/egcas/ --bindir=${CMAKE_BINARY_DIR}/maxima_installation/usr/bin/egcas/
    PREFIX ${CMAKE_BINARY_DIR}/maxima_installation
    BUILD_COMMAND make
    BUILD_IN_SOURCE 1
)

    
