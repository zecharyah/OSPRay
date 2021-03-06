@echo off
rem ======================================================================== rem
rem Copyright 2015-2016 Intel Corporation                                    rem
rem                                                                          rem
rem Licensed under the Apache License, Version 2.0 (the "License");          rem
rem you may not use this file except in compliance with the License.         rem
rem You may obtain a copy of the License at                                  rem
rem                                                                          rem
rem     http://www.apache.org/licenses/LICENSE-2.0                           rem
rem                                                                          rem
rem Unless required by applicable law or agreed to in writing, software      rem
rem distributed under the License is distributed on an "AS IS" BASIS,        rem
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. rem
rem See the License for the specific language governing permissions and      rem
rem limitations under the License.                                           rem
rem ======================================================================== rem

setlocal
rem set TBB_PATH_LOCAL=%cd%\tbb

md build_release
cd build_release

rem set release settings
cmake -L ^
-G "Visual Studio 12 2013 Win64" ^
-T "Intel C++ Compiler 16.0" ^
-D OSPRAY_ZIP_MODE=OFF ^
-D OSPRAY_BUILD_ISA=ALL ^
-D OSPRAY_BUILD_MIC_SUPPORT=OFF ^
-D OSPRAY_USE_EXTERNAL_EMBREE=ON ^
-D embree_DIR=..\..\embree\lib\cmake\embree-2.9.0 ^
-D USE_IMAGE_MAGICK=OFF ^
-D CMAKE_INSTALL_INCLUDEDIR=include ^
-D CMAKE_INSTALL_LIBDIR=lib ^
-D CMAKE_INSTALL_DATAROOTDIR= ^
-D CMAKE_INSTALL_DOCDIR=doc ^
-D CMAKE_INSTALL_BINDIR=bin ^
..
rem -D TBB_ROOT=%TBB_PATH_LOCAL% ^

rem compile and create installers
# option '--clean-first' somehow conflicts with options after '--' for msbuild
cmake --build . --config Release --target PACKAGE -- /m /nologo

rem create ZIP files
cmake -D OSPRAY_ZIP_MODE=ON ..
cmake --build . --config Release --target PACKAGE -- /m /nologo

cd ..

:abort
endlocal
:end
