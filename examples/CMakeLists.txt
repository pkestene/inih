cmake_minimum_required(VERSION 3.13)
project(inihExamples LANGUAGES C CXX)

# set path to find our FindInih.cmake
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/../cmake/Modules)

# let's first try the config mode
# see : https://cmake.org/cmake/help/latest/command/find_package.html#id3
find_package(INIH CONFIG)

# if INIH is not found by the config mode, let's try the module mode
if(NOT INIH_FOUND)

  # try the module mode
  find_package(INIH REQUIRED)

endif()

#
# build example
#
if (INIH_FOUND)
  if (INIH_INIREADER_FOUND)
    message("INIReader component was found.")
    add_executable(INIReaderExample)
    target_sources(INIReaderExample
      PRIVATE
      INIReaderExample.cpp)
    target_link_libraries(INIReaderExample
      PRIVATE
      INIH::INIReader
      INIH::inih)
  else()
    message("INIReader component was not found, can't build anything.")
  endif()
endif()
