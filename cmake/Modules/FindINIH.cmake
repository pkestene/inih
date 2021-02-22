# FindINIH.cmake
# ---------------
#
# Find inih library
#
# Result Variables
# ----------------
#
# This module defines the following variables::
#
#   INIH_FOUND
#   INIH_INCLUDE_DIRS   - include directories for inih
#   INIH_LIBRARIES      - link against this library to use inih
#
# Imported Targets
# ^^^^^^^^^^^^^^^^
#   INIH::inih
#   INIH::INIReader


find_path (INIH_INCLUDE_DIR
  NAMES inih.h
  DOC "inih header")

find_library (INIH_LIBRARY
  NAMES inih
  DOC "inih library")

if(INIH_LIBRARY AND INIH_INCLUDE_DIR)
  set(INIH_INIH_FOUND true)
endif()

if(INIReader IN_LIST INIH_FIND_COMPONENTS)
  find_library (INIREADER_LIBRARY
    NAMES INIReader
    DOC "INIReader library")

  if(INIREADER_LIBRARY)
    set(INIH_INIREADER_FOUND true)
  endif()
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args (INIH
  REQUIRED_VARS INIH_LIBRARY INIH_INCLUDE_DIR
  HANDLE_COMPONENTS)

if(INIH_FOUND)

  set(INIH_INCLUDE_DIRS ${INIH_INCLUDE_DIR})
  set(INIH_LIBRARIES ${INIH_LIBRARY})

  if(NOT TARGET INIH::inih)
    add_library(INIH::inih INTERFACE IMPORTED)
    set_target_properties(INIH::inih PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${INIH_INCLUDE_DIR}"
      INTERFACE_LINK_LIBRARIES "${INIH_LIBRARY}"
      )
  endif()

  if (INIH_INIREADER_FOUND)
    if(NOT TARGET INIH::INIReader)
      add_library(INIH::INIReader INTERFACE IMPORTED)
      set_target_properties(INIH::INIReader PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${INIREADER_INCLUDE_DIR}"
        INTERFACE_LINK_LIBRARIES "${INIREADER_LIBRARY}"
        )
    endif()
  endif()

endif()

mark_as_advanced(
  INIH_INCLUDE_DIR
  INIH_LIBRARY
  INIREADER_INCLUDE_DIR
  INIREADER_LIBRARY
  )
