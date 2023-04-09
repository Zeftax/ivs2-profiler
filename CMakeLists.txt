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

cmake_minimum_required(VERSION 3.16)
project(ivs2-profiler)

set(CMAKE_PREFIX_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../ivs2-mathlib/install")
find_package(ivs2-mathlib 0.1 CONFIG REQUIRED)


set(CMAKE_CXX_STANDARD 17)

add_executable(${PROJECT_NAME})

target_sources(${PROJECT_NAME}
    PRIVATE
        src/profiler.cpp
)

target_link_libraries(${PROJECT_NAME} PRIVATE ivsm::ivs2-mathlib)

