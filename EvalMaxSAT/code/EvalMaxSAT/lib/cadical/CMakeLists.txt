cmake_minimum_required(VERSION 2.8)


get_filename_component(projectName ${CMAKE_CURRENT_SOURCE_DIR} NAME)

message("cmake for ${projectName}")


file(
        GLOB_RECURSE
        source_files
        src/*
)

set(localLibs

        )

set(externLibs
        m
        z
        )

add_definitions(-DNDEBUG)
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++1z -Wall -O3 -static -lrt -pthread -Wl,--whole-archive -lpthread -Wl,--no-whole-archive")


find_package(ZLIB)
include_directories(${ZLIB_INCLUDE_DIR})


if(TARGET ${projectName})

    message("${projectName} is already defined")

else()

    FOREACH (localLib ${localLibs})
        add_subdirectory (./../${localLib} ${localLib})
    ENDFOREACH(localLib)

    include_directories (src)

    message(STATUS "foo include dir: ${source_files}")
    add_library (
            ${projectName}
            ${source_files}
    )

    install(TARGETS ${projectName} 	LIBRARY DESTINATION lib
            ARCHIVE DESTINATION lib
            )


    FOREACH (localLib ${localLibs})
        include_directories (../${localLib}/src)
    ENDFOREACH(localLib)




    set(LIB_LINK
            ${localLibs}
            ${externLibs}
            )

    target_link_libraries(${projectName}
            ${LIB_LINK}
            )


endif()




