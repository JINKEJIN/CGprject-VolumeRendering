cmake_minimum_required(VERSION 3.8)
project(volumetric_rendering)

set(CMAKE_CXX_STANDARD 11)

set(SOURCE_FILES
        glew/include/GL/glew.h
        glew/include/GL/glxew.h
        glew/include/GL/wglew.h
        glew/src/glew.arb.c
        glew/src/glew.c
        glew/src/glewinfo.c
        glew/src/visualinfo.c
        lib/win32/glut/GL/glut.h
        glsl.cpp
        glsl.h
        SimpleFragmentShader.fp
        SimpleVertexShader.vp
        TextureLoader.cpp
        TextureLoader.h
        volume_render.cpp)

add_executable(volumetric_rendering ${SOURCE_FILES})