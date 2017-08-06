cmake_minimum_required(VERSION 2.8)

set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_VERBOSE_MAKEFILE ON)

project(egcas_maxima)

include(ExternalProject)

if (NOT MAXIMA_INST_PATH)
        set(MAXIMA_INST_PATH maxima_installation)
endif()


if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
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

        set(MAXIMA_INSTALL_DIR /usr/bin/egcas-maxima)
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
        add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}/bin/maxima.bat
                                    COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/win_crosscompile.sh -C ${CMAKE_SOURCE_DIR}/build_mxe/mxe/usr/bin/i686-w64-mingw32.shared-cmake -i ${CMAKE_BINARY_DIR}/${MAXIMA_INST_PATH}
                                    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} 
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

