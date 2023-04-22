set(CPACK_PACKAGE_NAME "ivs-${PROJECT_NAME}")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Standard deviation calculator to profile our ivs math library")
set(CPACK_PACKAGE_VERSION "${CMAKE_PROJECT_VERSION}")

set(CPACK_PACKAGE_VENDOR "The FitnessGram Pacer test is a multistage aerobic capacity test that progressively gets more difficult as it continues. The 20 meter Pacer test will begin in 30 seconds. Line up at the start.")
set(CPACK_PACKAGE_CONTACT "xkrejc84@vutbr.cz")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Tomáš Krejčí <${CPACK_PACKAGE_CONTACT}>")

set(CPACK_PACKAGE_INSTALL_DIRECTORY ${CPACK_PACKAGE_NAME})
set(CPACK_OUTPUT_FILE_PREFIX "${CMAKE_SOURCE_DIR}/_packages")

set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/COPYING")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")

set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS YES)

include(CPack)
