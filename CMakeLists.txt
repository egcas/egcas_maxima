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
#                      --datarootdir=${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/usr/share/egcas/
                      --prefix=${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/ 
#                      --program-prefix=egcas-
#                      --libexecdir=${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/usr/bin/egcas/
#                      --libdir=${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/usr/lib/egcas/
#                      --bindir=${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/usr/bin/
                      --enable-sbcl
    PREFIX ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}
    BUILD_COMMAND make
#    COMMAND find ${CMAKE_CURRENT_SOURCE_DIR} -type f -exec sed -i s=${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/=/=g {} +
#    COMMAND find ${CMAKE_CURRENT_SOURCE_DIR} -type f -exec sed -i s=${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}=/=g {} +
    BUILD_IN_SOURCE 1
)

#ExternalProject_Add_Step(egcas_maxima after_install
#    COMMAND find ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH} -type f -exec sed -i s=${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/=${CMAKE_BINARY_DIR}/_${MAXIMA_INST_PATH}/=g {} +
#    COMMAND find ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH} -type f -exec sed -i s=${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}=${CMAKE_BINARY_DIR}/_${MAXIMA_INST_PATH}=g {} +
#    DEPENDEES install
#)

if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
        install(PROGRAMS ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/usr/bin/egcas-maxima DESTINATION /usr/bin/)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/usr/bin/egcas DESTINATION /usr/bin/ PATTERN * PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/usr/lib/ DESTINATION /usr/lib/ PATTERN lisp.run EXCLUDE)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/usr/lib/ DESTINATION /usr/lib/ PATTERN lisp.run PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/usr/share/ DESTINATION /usr/share/)
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Windows")

endif()

