cmake_minimum_required(VERSION 3.13)
project(inihExamples LANGUAGES C CXX)

# set path to find FindInih.cmake
#list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/../cmake/Modules)

find_package(INIH REQUIRED CONFIG)

if (INIH_FOUND)
  add_executable(INIReaderExample)
  target_sources(INIReaderExample
    PRIVATE
    INIReaderExample.cpp)
  target_link_libraries(INIReaderExample
    PRIVATE
    INIH::INIReader
    INIH::inih)
endif()
