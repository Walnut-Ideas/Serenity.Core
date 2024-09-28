# check what platform we're on (64-bit or 32-bit), and create a simpler test than CMAKE_SIZEOF_VOID_P
if (CMAKE_SIZEOF_VOID_P MATCHES 8)
    set(PLATFORM 64)
    MESSAGE(STATUS "Detected 64-Bit Platform")
else ()
    set(PLATFORM 32)
    MESSAGE(STATUS "Detected 32-Bit Platform")
endif ()

if (CMAKE_SYSTEM_PROCESSOR MATCHES "amd64|x86_64|AMD64")
    set(SERENITY_SYSTEM_PROCESSOR "amd64")
elseif (CMAKE_SYSTEM_PROCESSOR MATCHES "^(arm|ARM|aarch)64$")
    set(SERENITY_SYSTEM_PROCESSOR "arm64")
elseif (CMAKE_SYSTEM_PROCESSOR MATCHES "^(arm|ARM)$")
    set(SERENITY_SYSTEM_PROCESSOR "arm")
else ()
    set(SERENITY_SYSTEM_PROCESSOR "x86")
endif ()

# detect MSVC special case of using cmake -A switch (which doesn't set any cross compiling variables)
if (CMAKE_GENERATOR_PLATFORM STREQUAL "Win32")
    set(SERENITY_SYSTEM_PROCESSOR "x86")
elseif (CMAKE_GENERATOR_PLATFORM STREQUAL "x64")
    set(SERENITY_SYSTEM_PROCESSOR "amd64")
elseif (CMAKE_GENERATOR_PLATFORM STREQUAL "ARM")
    set(SERENITY_SYSTEM_PROCESSOR "arm")
elseif (CMAKE_GENERATOR_PLATFORM STREQUAL "ARM64")
    set(SERENITY_SYSTEM_PROCESSOR "arm64")
endif ()

message(STATUS "Detected ${SERENITY_SYSTEM_PROCESSOR} Processor Architecture")

if (WIN32)
    include("${CMAKE_SOURCE_DIR}/CMake/Platform/Windows/Settings.cmake")
elseif (UNIX)
    include("${CMAKE_SOURCE_DIR}/CMake/Platform/Unix/Settings.cmake")
endif ()

if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC" OR CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "MSVC")
    include("${CMAKE_SOURCE_DIR}/CMake/Compiler/MSVC/Settings.cmake")
elseif (CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    include("${CMAKE_SOURCE_DIR}/CMake/Compiler/Clang/Settings.cmake")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    include("${CMAKE_SOURCE_DIR}/CMake/Compiler/GCC/Settings.cmake")
endif ()