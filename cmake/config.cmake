# --- generate pkg-config .pc

set(pc_req_public "inih")
configure_file(${CMAKE_CURRENT_LIST_DIR}/inih.pc.in inih.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/inih.pc DESTINATION lib/pkgconfig)


if(with_INIReader)
  string(PREPEND pc_req_public "INIReader ")
  configure_file(${CMAKE_CURRENT_LIST_DIR}/INIReader.pc.in INIReader.pc @ONLY)
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/INIReader.pc DESTINATION lib/pkgconfig)
endif(with_INIReader)

