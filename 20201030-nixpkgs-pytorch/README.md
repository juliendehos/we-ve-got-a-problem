Fixed

## Problem

The cmake config for pytorch seems to be broken. 
Cmake fails when using `find_package(Torch REQUIRED)` in a `CMakeLists.txt`.


## Expected

```
$ nix-shell
$ cmake -S . -B build
$ cmake --build build
$ ./build/myapp
```


## Got

```
$ nix-shell
$ cmake -S . -B build
-- The C compiler identification is GNU 9.3.0
-- The CXX compiler identification is GNU 9.3.0
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /nix/store/8madhhcxhxlf0rrc5hdsk65l206r3cc6-gcc-wrapper-9.3.0/bin/gcc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /nix/store/8madhhcxhxlf0rrc5hdsk65l206r3cc6-gcc-wrapper-9.3.0/bin/g++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Looking for pthread.h
-- Looking for pthread.h - found
-- Performing Test CMAKE_HAVE_LIBC_PTHREAD
-- Performing Test CMAKE_HAVE_LIBC_PTHREAD - Failed
-- Looking for pthread_create in pthreads
-- Looking for pthread_create in pthreads - not found
-- Looking for pthread_create in pthread
-- Looking for pthread_create in pthread - found
-- Found Threads: TRUE  
CMake Error at /nix/store/29d39wh35a7l3iv8s7xlzcjdmf8mp36v-python3.8-pytorch-1.6.0-dev/share/cmake/Caffe2/Caffe2Targets.cmake:116 (message):
  The imported target "c10" references the file

     "/nix/store/29d39wh35a7l3iv8s7xlzcjdmf8mp36v-python3.8-pytorch-1.6.0-dev/lib/libc10.so"

  but this file does not exist.  Possible reasons include:

  * The file was deleted, renamed, or moved to another location.

  * An install or uninstall procedure did not complete successfully.

  * The installation package was faulty and contained

     "/nix/store/29d39wh35a7l3iv8s7xlzcjdmf8mp36v-python3.8-pytorch-1.6.0-dev/share/cmake/Caffe2/Caffe2Targets.cmake"

  but not all the files it references.

Call Stack (most recent call first):
  /nix/store/29d39wh35a7l3iv8s7xlzcjdmf8mp36v-python3.8-pytorch-1.6.0-dev/share/cmake/Caffe2/Caffe2Config.cmake:116 (include)
  /nix/store/29d39wh35a7l3iv8s7xlzcjdmf8mp36v-python3.8-pytorch-1.6.0-dev/share/cmake/Torch/TorchConfig.cmake:40 (find_package)
  CMakeLists.txt:4 (find_package)


-- Configuring incomplete, errors occurred!
See also "/home/jd/depots/github/juliendehos/we-ve-got-a-problem/20201030-nixpkgs-pytorch/build/CMakeFiles/CMakeOutput.log".
See also "/home/jd/depots/github/juliendehos/we-ve-got-a-problem/20201030-nixpkgs-pytorch/build/CMakeFiles/CMakeError.log".
```

## Could help

```
$ find /nix/store/*pytorch* -name "libc10.so"
/nix/store/3x5pr1irgjhdnkplda0p8sx4c7dw5vx1-python3.8-pytorch-1.6.0-lib/lib/libc10.so
/nix/store/j8rswbn7m64fzq61ijxqy2k5g0ai6v1g-python3.8-pytorch-1.6.0/lib/python3.8/site-packages/torch/lib/libc10.so
```

## Solution

issue: <https://github.com/NixOS/nixpkgs/issues/102146>

pull request: <https://github.com/NixOS/nixpkgs/pull/105772>

```
$ nix-shell default-fixed.nix
$ cmake -S . -B build
$ cmake --build build
$ ./build/myapp
```

