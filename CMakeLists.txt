cmake_minimum_required(VERSION 2.8)

set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_VERBOSE_MAKEFILE ON)

project(egcas_maxima)

include(ExternalProject)

if (NOT MAXIMA_INST_PATH)
        set(MAXIMA_INST_PATH maxima_installation)
endif()


file(COPY ${CMAKE_CURRENT_SOURCE_DIR} DESTINATION ${CMAKE_BINARY_DIR}/egcas_maxima_source/)
set(MAXIMA_BUILD_DIRECTORY ${CMAKE_BINARY_DIR}/egcas_maxima_source/egcas_maxima/)

if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
        ExternalProject_Add(egcas_maxima
            PATCH_COMMAND touch ${MAXIMA_BUILD_DIRECTORY}/maxima/configure.ac ${MAXIMA_BUILD_DIRECTORY}/maxima/aclocal.m4 ${MAXIMA_BUILD_DIRECTORY}/maxima/configure ${MAXIMA_BUILD_DIRECTORY}/maxima/Makefile.am ${MAXIMA_BUILD_DIRECTORY}/maxima/Makefile.in
            SOURCE_DIR ${MAXIMA_BUILD_DIRECTORY}/maxima
            CONFIGURE_COMMAND ${MAXIMA_BUILD_DIRECTORY}/maxima/configure
                              --prefix=${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/
                              --enable-sbcl
            PREFIX ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}
            BUILD_COMMAND make
            BUILD_IN_SOURCE 1
        )

        set(MAXIMA_INSTALL_DIR /usr/bin/egcas-maxima)
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
        add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/bin/maxima.bat
                                    COMMAND ${MAXIMA_BUILD_DIRECTORY}/win_crosscompile.sh -C ${CMAKE_SOURCE_DIR}/build_mxe/mxe/usr/bin/i686-w64-mingw32.shared-cmake -i ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}
                                    WORKING_DIRECTORY ${MAXIMA_BUILD_DIRECTORY}
                                    COMMENT "cross compile maxima for windows"
                                    VERBATIM)
        add_custom_target(egcas_maxima DEPENDS ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/bin/maxima.bat)

        set(MAXIMA_INSTALL_DIR egcas-maxima)
endif()

if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
        install(PROGRAMS ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/bin/maxima DESTINATION ${MAXIMA_INSTALL_DIR}/bin)
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
        install(CODE "execute_process(COMMAND \"${CMAKE_COMMAND}\" --build \"${CMAKE_CURRENT_BINARY_DIR}\" --target egcas_maxima)")
        install(PROGRAMS ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/bin/maxima.bat DESTINATION ${MAXIMA_INSTALL_DIR}/bin)
        install(FILES ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/bin/maxima-command.ico DESTINATION ${MAXIMA_INSTALL_DIR}/bin)
        install(FILES ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/bin/set_lang.vbs DESTINATION ${MAXIMA_INSTALL_DIR}/bin)
endif()
install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/lib/ DESTINATION ${MAXIMA_INSTALL_DIR}/lib/)
install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/libexec/ DESTINATION ${MAXIMA_INSTALL_DIR}/libexec/)
install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/share/ DESTINATION ${MAXIMA_INSTALL_DIR}/share/)
if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/src/ DESTINATION ${MAXIMA_INSTALL_DIR}/src/)
        install(DIRECTORY ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/tmp/ DESTINATION ${MAXIMA_INSTALL_DIR}/tmp/)
endif()

