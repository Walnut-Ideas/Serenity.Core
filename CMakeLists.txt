cmake_minimum_required(VERSION 3.27)

# Set Project name
project(Serenity.Core)

# Set CMake CXX Standards
set(CMAKE_CXX_STANDARD 23)

# Set CMake Policy settings

# Append custom CMake-Macro directory
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/CMake/Macros")


include(CheckCXXSourceRuns)
include(CheckIncludeFiles)

# set default buildoptions and print them
include(CMake/Options.cmake)

include(TargetConfiguration)
include(CheckPlatform)

include(GroupSources)
include(AutoCollect)

# print out the results before continuing
include(CMake/ShowOptions.cmake)

# Add Dependencies
add_subdirectory(Dependencies)

# Add Sources
add_subdirectory(Sources)