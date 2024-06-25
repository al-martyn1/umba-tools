cmake_minimum_required(VERSION 3.21)
project(umba-tools C CXX)


set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)


set(PRJ_ROOT "${CMAKE_CURRENT_LIST_DIR}")
set(SRC_ROOT "${PRJ_ROOT}/src")
set(LIB_ROOT "${PRJ_ROOT}/_libs")
set(SUBPROJECTS_ROOT "${PRJ_ROOT}/..")


include_directories(${LIB_ROOT})

add_subdirectory(${SUBPROJECTS_ROOT}/umba-md-pp ".out")
# add_subdirectory(${SUBPROJECTS_ROOT}/umba-msvc-filters ".out")

