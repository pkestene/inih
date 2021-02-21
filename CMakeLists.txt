cmake_minimum_required(VERSION 3.13)

include(cmake/policy.cmake)
include(cmake/git.cmake)

project(INIH
LANGUAGES C CXX
HOMEPAGE_URL https://github.com/benhoyt/inih
DESCRIPTION "Simple .INI file parser in C, good for embedded system"
VERSION ${PROJECT_VERSION})

message(STATUS "${PROJECT_NAME} ${PROJECT_VERSION}")

include(CTest)
include(GNUInstallDirs)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/Modules)

# --- user options

include(cmake/options.cmake)
include(cmake/compilers.cmake)

# --- configure inih

include(cmake/config.cmake)

# --- inih library
add_library(inih)
target_include_directories(inih
  PRIVATE ${PROJECT_BINARY_DIR}
  INTERFACE
  $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
  $<INSTALL_INTERFACE:include>)
target_sources(inih PRIVATE ini.c)

install(FILES ini.h
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

install(TARGETS inih
  EXPORT ${PROJECT_NAME}Targets
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

add_library(INIH::inih INTERFACE IMPORTED GLOBAL)
target_link_libraries(INIH::inih INTERFACE inih)


# --- INIReader library
if(with_inireader)

  add_library(INIReader)
  target_include_directories(INIReader
    PRIVATE ${PROJECT_BINARY_DIR}
    INTERFACE
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:include>)
  target_sources(INIReader PRIVATE cpp/INIReader.cpp)

  install(FILES cpp/INIReader.h
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

  install(TARGETS INIReader
    EXPORT ${PROJECT_NAME}Targets
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

  add_library(INIH::INIReader INTERFACE IMPORTED GLOBAL)
  target_link_libraries(INIH::INIReader INTERFACE INIReader)

endif(with_inireader)

# --- tests

# --- install targets

include(cmake/install.cmake)
