###################################################
# Project name: ivs2-profiler
# Date:         2023-04-09
# File:         CMakeLists.txt
#
# Author: Zdeněk Borovec <xborov08@vutbr.cz>
# Author: Tomáš Krejčí   <xkrejc84@vutbr.cz>
# Author: Jan Lozrt      <xlozrt00@vutbr.cz>
# Author: Jakub Mitrenga <xmitre07@vutbr.cz>
#
# Description: Profiler for testing the performance of our ivs2-mathlib math library
# 
# Usage: 
#   mkdir build
#   cd build
#   cmake ..
#   make
###################################################

# == SETUP ==
cmake_minimum_required(VERSION 3.16)
project("ivs2-profiler"
        VERSION 1.0.0
        DESCRIPTION "Profiler for testing the performance of our ivs2-mathlib math library"
)

# find math library
set(CMAKE_PREFIX_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../ivs2-mathlib/install")
find_package(ivs2-mathlib 0.1 CONFIG REQUIRED)

set(CMAKE_CXX_STANDARD 17)

add_executable(${PROJECT_NAME})

target_sources(${PROJECT_NAME}
    PRIVATE
        src/profiler.cpp
)

target_link_libraries(${PROJECT_NAME} PRIVATE ivsm::ivs2-mathlib)


set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(Install)
include(Package)

set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME "stddev")


# == TESTING ==
enable_testing()

add_test(
    NAME 10_samples 
    COMMAND sh -c "${CMAKE_CURRENT_SOURCE_DIR}/_build/stddev < ${CMAKE_CURRENT_SOURCE_DIR}/tst/data10.txt"
)
set_tests_properties(10_samples
    PROPERTIES PASS_REGULAR_EXPRESSION "307604\.4151")

add_test(
    NAME 1k_samples 
    COMMAND sh -c "${CMAKE_CURRENT_SOURCE_DIR}/_build/stddev < ${CMAKE_CURRENT_SOURCE_DIR}/tst/data1k.txt"
)
set_tests_properties(1k_samples
    PROPERTIES PASS_REGULAR_EXPRESSION "290327\.7403")

add_test(
    NAME 1m_samples 
    COMMAND sh -c "${CMAKE_CURRENT_SOURCE_DIR}/_build/stddev < ${CMAKE_CURRENT_SOURCE_DIR}/tst/data1m.txt"
)
set_tests_properties(1m_samples
    PROPERTIES PASS_REGULAR_EXPRESSION "291538\.4336")

add_test(
    NAME bad_input 
    COMMAND sh -c "${CMAKE_CURRENT_SOURCE_DIR}/_build/stddev < ${CMAKE_CURRENT_SOURCE_DIR}/tst/dataBad.txt"
)
set_tests_properties(bad_input
    PROPERTIES WILL_FAIL TRUE)

add_test(
    NAME short_input 
    COMMAND sh -c "${CMAKE_CURRENT_SOURCE_DIR}/_build/stddev < ${CMAKE_CURRENT_SOURCE_DIR}/tst/dataShort.txt"
)
set_tests_properties(short_input
    PROPERTIES WILL_FAIL TRUE)
